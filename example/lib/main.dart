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

import 'package:bottom_inset_observer/bottom_inset_observer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard listener example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Keyboard listener example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _status = '';

  bool _isVisible = false;
  late BottomInsetObserver _insetObserver;

  @override
  void initState() {
    super.initState();

    /// Create instance of the observer and add changes listener
    /// Note: if viewInsets.bottom > 0 -> handler called immediately
    /// with current inset and delta == 0
    _insetObserver = BottomInsetObserver()..addListener(_keyboardHandle);
  }

  @override
  void dispose() {
    /// Unregisters the observer observer and remove all listeners
    _insetObserver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Text(_isVisible ? 'Visible' : 'Hidden'),
          Text('Change status: $_status'),
          const SizedBox(height: 50),
          const TextField(),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              if (FocusManager.instance.primaryFocus != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              } else {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            child: const Text('Reset focus'),
          ),
          ElevatedButton(
            onPressed: () {
              /// You can remove listener manually
              _insetObserver.removeListener(_keyboardHandle);
            },
            child: const Text('Remove listener'),
          ),
        ],
      ),
    );
  }

  /// Inset change handler
  /// Will be called when subscribing if there is an inset > 0,
  /// further on every inset change
  void _keyboardHandle(BottomInsetChanges change) {
    setState(() {
      /// getting current inset and check current status
      /// of keyboard visability
      _isVisible = change.currentInset > 0;

      /// get delta since last change and check current status of changes
      if (change.delta == 0) _status = 'idle';
      if (change.delta > 0) _status = 'increase';
      if (change.delta < 0) _status = 'decrease';
    });
  }
}
