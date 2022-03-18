# Keyboard Listener

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/keyboard_listener)

This package made by [Surf](https://surf.ru).

## Description

BottomInsetObserver - пакет для отслеживания изменений нижнего отступа (viewInsets.bottom) с помощью callBack функций.

## Installation

Add `keyboard_listener` to your `pubspec.yaml` file:

```yaml
dependencies:
  keyboard_listener:
    git:
      url: git://github.com/surfstudio/flutter-keyboard-listener.git
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

For issues, file directly in the Issues section.

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please review our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
