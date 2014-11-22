library unhexme_up_down_key_component;

import 'package:angular/angular.dart';
import 'package:hexbit/math.dart';
import 'dart:html';

@Decorator(selector: '[key-cycle]')
class UpDownKeyBound {

  CharacterAdder _adder;
  Element e;
  NgModel model;
  Scope scope;

  UpDownKeyBound(this.e, this.model, this.scope) {
    e.onKeyDown.listen(keyDown);
  }

  @NgAttr('key-cycle')
  set keyCycle(String val) {
    if (val == "hex") {
      _adder = _hexAdder;
    } else if (val == "char") {
      _adder = _characterAdder;
    } else {
      _adder = _integerAdder;
    }
  }

  void keyDown(KeyboardEvent event) {
    InputElement input = event.target;
    if (event.keyCode == 38) {
      add(input, 1);
      event.preventDefault();
    } else if (event.keyCode == 40) {
      add(input, -1);
      event.preventDefault();
    }
  }

  void add(InputElement input, num increment) {
    var value = input.value;
    if (value.length > 0 && model.valid) {
      _Update update = _adder(input, increment);
      model.modelValue = update.value;
      model.render(update.value);
      scope.rootScope.domWrite(() {
        input.selectionStart = update.selectionStart;
        input.selectionEnd = update.selectionEnd;
      });
    }
  }

}

class _Update {
  String value;
  int selectionStart;
  int selectionEnd;

  _Update(this.value, this.selectionStart, this.selectionEnd);

}

typedef _Update CharacterAdder(InputElement input, int b);

_Update _hexAdder(InputElement input, int increment) {
  var start = input.selectionStart;
  var end = input.selectionEnd;
  String value = input.value;
  if (start == end) {
    if (start == value.length) {
      start = value.length - 1;
    } else {
      end++;
    }
  }
  if (end - start == 1) {
    var character = value.substring(start, end).toLowerCase();
    var newValue = value.substring(0, start) + Math.add(character, increment) + value.substring(end);
    return new _Update(newValue, start, end);
  }
  return null;
}

_Update _integerAdder(InputElement input, int increment) {
  String value = input.value;
  var newInt = int.parse(value) + increment;
  if (newInt > 255) newInt = 0;
  if (newInt < 0) newInt = 255;
  return new _Update(newInt.toString(), 0, value.length);
}

_Update _characterAdder(InputElement input, int increment) {
  String value = input.value;
  var newInt = value.codeUnitAt(0) + increment;
  if (newInt > 255) newInt = 0;
  if (newInt < 0) newInt = 255;
  return new _Update(new String.fromCharCode(newInt), 0, value.length);
}