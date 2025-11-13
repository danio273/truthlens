import 'dart:js_interop';
import 'dart:async';

@JS()
external JSObject get window;

@JS('chromeExtensionInterop.getSelectedText')
external JSPromise<JSString> _getSelectedText();

Future<String> getSelectedText() async {
  final jsPromise = _getSelectedText();
  final jsString = await jsPromise.toDart;
  return jsString.toDart;
}
