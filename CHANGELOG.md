# Changelog

## 3.0.0

### Changed
* Renamed package to bottom_inset_observer;
* Callback function uses BottomInsetChanges as argument;
* Arguments addListener uses BottomInsetChangeListener instead String? id, KeyboardChangeListener? onChange, VoidCallback? onShow, VoidCallback? onHide;

### Removed
* Callback onShow;
* Callback onHide;
* Method removeChangeListener(KeyboardChangeListener listener);
* Method removeShowListener(VoidCallback listener);
* Method removeHideListener(VoidCallback listener);
* Method removeAtChangeListener(String id);
* Method removeAtShowListener(String id);
* Method removeAtHideListener(String id);


## 2.0.0

* Migrate this package to null safety.

## 1.0.0-dev.0

* Initial release
