// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:ui';

import 'package:bottom_inset_observer/src/bottom_inset_observer.dart';
import 'package:flutter/widgets.dart' hide KeyboardListener;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BottomInsetObserver _insetObserver;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    _insetObserver = BottomInsetObserver();
  });

  testWidgets('Change listener test', (tester) async {
    final testBinding = tester.binding;
    final pixelRatio = testBinding.window.devicePixelRatio;
    testBinding.window.viewInsetsTestValue = const FakeWindowPadding();

    late BottomInsetChanges currentChange;
    void onChange(BottomInsetChanges change) {
      currentChange = change;
    }

    _insetObserver.addListener(onChange);

    testBinding.window.viewInsetsTestValue =
        const FakeWindowPadding(bottom: 25);

    expect(currentChange.currentInset, moreOrLessEquals(25 / pixelRatio));
    expect(currentChange.delta, moreOrLessEquals(25 / pixelRatio));

    testBinding.window.viewInsetsTestValue =
        const FakeWindowPadding(bottom: 35);

    expect(currentChange.currentInset, moreOrLessEquals(35 / pixelRatio));
    expect(currentChange.delta, moreOrLessEquals(10 / pixelRatio));

    _insetObserver.removeListener(onChange);

    testBinding.window.viewInsetsTestValue =
        const FakeWindowPadding(bottom: 45);

    expect(currentChange.currentInset, moreOrLessEquals(35 / pixelRatio));
    expect(currentChange.delta, moreOrLessEquals(10 / pixelRatio));
  });

  testWidgets('Change listener calls when inset > 0', (tester) async {
    final testBinding = tester.binding;
    testBinding.window.viewInsetsTestValue = const FakeWindowPadding();

    var isChange = false;
    void onChange(BottomInsetChanges _) {
      isChange = true;
    }

    testBinding.window.viewInsetsTestValue =
        const FakeWindowPadding(bottom: 25);

    _insetObserver.addListener(onChange);
    expect(isChange, true);
  });

  testWidgets('Disposing test', (tester) async {
    final testBinding = tester.binding;
    testBinding.window.viewInsetsTestValue = const FakeWindowPadding();

    var isChange = false;
    void onChange(BottomInsetChanges _) {
      isChange = true;
    }

    _insetObserver
      ..addListener(onChange)
      ..dispose();

    testBinding.window.viewInsetsTestValue =
        const FakeWindowPadding(bottom: 25);

    expect(isChange, false);
  });
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
