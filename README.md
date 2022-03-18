# Keyboard Listener

[![Build Status](https://shields.io/github/workflow/status/surfstudio/flutter-bottom-inset-observer/Analysis?logo=github&logoColor=white)](https://github.com/surfstudio/flutter-bottom-inset-observer)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/flutter-bottom-inset-observer?logo=codecov&logoColor=white)](https://app.codecov.io/gh/surfstudioflutter-bottom-inset-observer)
[![Pub Version](https://img.shields.io/pub/v/flutter-bottom-inset-observer?logo=dart&logoColor=white)](https://pub.dev/packages/flutter-bottom-inset-observer)
[![Pub Likes](https://badgen.net/pub/likes/flutter-bottom-inset-observer)](https://pub.dev/packages/flutter-bottom-inset-observer)
[![Pub popularity](https://badgen.net/pub/popularity/flutter-bottom-inset-observer)](https://pub.dev/packages/flutter-bottom-inset-observer/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/flutter-bottom-inset-observer)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru).

[![Surf Logger](https://i.ibb.co/8XD9Cbw/Bunner-LOGO.png)](https://github.com/surfstudio/SurfGear)

## Description

BottomInsetObserver - a package for large indent changes (viewInsets.bottom) using the callBack function.

## Installation

Add `bottom_inset_observer` to your `pubspec.yaml` file:


```yaml
dependencies:
  bottom_inset_observer: $currentVersion$
```

## Example
As an example, this package can be used to track the presence of a keyboard and handle its visibility status
```dart
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
 ```

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

To report your issues, submit them directly in the [Issues](https://github.com/surfstudio/flutter-bottom-inset-observer/issues) section.

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, fixing a bug or adding a cool new feature), please review our [contribution guide](/CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
