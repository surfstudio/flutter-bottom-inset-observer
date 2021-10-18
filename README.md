# Keyboard Listener

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/keyboard_listener)

This package made by [Surf](https://surf.ru).

## Description

Keyboard listener created only on Flutter

## Installation

Add `keyboard_listener` to your `pubspec.yaml` file:

```yaml
dependencies:
  keyboard_listener: ^2.0.0
```

You can use both `stable` and `dev` versions of the package listed above in the badges bar.

## Example

```dart
late KeyboardListener _keyboardListener;

@override
void initState() {
  super.initState();
  _keyboardListener = KeyboardListener()
    ..addListener(onChange: _keyboardHandle);
}

void _keyboardHandle(bool isVisible) {
  setState(() {
    _isVisible = isVisible;
  });
}

@override
void dispose() {
  _keyboardListener.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_isVisible ? 'Visible' : 'hidden'),
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
      ],
    ),
  );
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
