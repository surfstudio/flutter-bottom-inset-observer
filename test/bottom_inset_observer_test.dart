// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:ui';

import 'package:bottom_inset_observer/src/bottom_inset_observer.dart';
import 'package:flutter/widgets.dart' hide KeyboardListener;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BottomInsetObserver insetObserver;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    insetObserver = BottomInsetObserver();
  });

  testWidgets(
    'When the bottom padding changes, change listener must be called',
    (tester) async {
      final testBinding = tester.binding;
      final pixelRatio = testBinding.window.devicePixelRatio;
      testBinding.window.viewInsetsTestValue = const FakeWindowPadding();

      late BottomInsetChanges currentChange;
      void onChange(BottomInsetChanges change) {
        currentChange = change;
      }

      insetObserver.addListener(onChange);

      testBinding.window.viewInsetsTestValue =
          const FakeWindowPadding(bottom: 25);

      expect(currentChange.currentInset, moreOrLessEquals(25 / pixelRatio));
      expect(currentChange.delta, moreOrLessEquals(25 / pixelRatio));

      testBinding.window.viewInsetsTestValue =
          const FakeWindowPadding(bottom: 35);

      expect(currentChange.currentInset, moreOrLessEquals(35 / pixelRatio));
      expect(currentChange.delta, moreOrLessEquals(10 / pixelRatio));

      insetObserver.removeListener(onChange);

      testBinding.window.viewInsetsTestValue =
          const FakeWindowPadding(bottom: 45);

      expect(currentChange.currentInset, moreOrLessEquals(35 / pixelRatio));
      expect(currentChange.delta, moreOrLessEquals(10 / pixelRatio));
    },
  );

  testWidgets(
    'Change listener calls when inset > 0',
    (tester) async {
      final testBinding = tester.binding;
      testBinding.window.viewInsetsTestValue = const FakeWindowPadding();

      var isChange = false;
      void onChange(BottomInsetChanges _) {
        isChange = true;
      }

      testBinding.window.viewInsetsTestValue =
          const FakeWindowPadding(bottom: 25);

      insetObserver.addListener(onChange);
      expect(isChange, true);
    },
  );

  testWidgets(
    'If dispose BottomInsetObserver change listener should not be called',
    (tester) async {
      final testBinding = tester.binding;
      testBinding.window.viewInsetsTestValue = const FakeWindowPadding();

      var isChange = false;
      void onChange(BottomInsetChanges _) {
        isChange = true;
      }

      insetObserver
        ..addListener(onChange)
        ..dispose();

      testBinding.window.viewInsetsTestValue =
          const FakeWindowPadding(bottom: 25);

      expect(isChange, false);
    },
  );
}

class FakeWindowPadding implements WindowPadding {
  @override
  final double left;

  @override
  final double top;

  @override
  final double right;

  @override
  final double bottom;

  const FakeWindowPadding({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });
}
