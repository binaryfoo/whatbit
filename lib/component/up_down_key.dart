library unhexme_up_down_key_component;

import 'package:angular/angular.dart';
import 'package:hexbit/math.dart';
import 'dart:html';
import 'dart:math';

@Decorator(selector: 'input[key-cycle]')
class UpDownKeyBound {

  InputAdder _adder;
  Element e;
  NgModel model;
  Scope scope;

  UpDownKeyBound(this.e, this.model, this.scope) {
    e.onKeyDown.listen(keyDown);
  }

  @NgAttr('key-cycle')
  set keyCycle(String val) {
    if (val == "hex") {
      _adder = hexAdder;
    } else if (val == "char") {
      _adder = characterAdder;
    } else {
      _adder = integerAdder;
    }
  }

  void keyDown(KeyboardEvent event) {
    var i = _incrementFor(event);
    if (i != 0) {
      add(i);
      event.preventDefault();
    }
  }

  int _incrementFor(KeyboardEvent e) {
    switch (e.keyCode) {
      case KeyCode.UP: return 1;
      case KeyCode.DOWN: return -1;
      default: return 0;
    }
  }

  void add(num increment) {
    InputElement input = e as InputElement;
    if (input.value.length > 0 && model.valid) {
      Update update = _adder(input, increment);
      model.modelValue = update.value;
      model.render(update.value);
      scope.rootScope.domWrite(() {
        input.selectionStart = update.selectionStart;
        input.selectionEnd = update.selectionEnd;
      });
    }
  }

}

class Update {
  String value;
  int selectionStart;
  int selectionEnd;

  Update(this.value, this.selectionStart, this.selectionEnd);

}

typedef Update InputAdder(InputElement input, int b);

Update hexAdder(InputElement input, int increment) {
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
  var character = value.substring(start, end).toLowerCase();
  var newValue = value.substring(0, start) + Math.add(character, increment) + value.substring(end);
  return new Update(newValue, start, end);
}

Update integerAdder(InputElement input, int increment) {
  String value = input.value;
  var newInt = int.parse(value) + increment;
  if (newInt > 255) newInt = 0;
  if (newInt < 0) newInt = 255;
  return new Update(newInt.toString(), 0, value.length);
}

Update characterAdder(InputElement input, int increment) {
  String value = input.value;
  var newInt = value.codeUnitAt(0) + increment;
  if (newInt > 255) newInt = 0;
  if (newInt < 0) newInt = 255;
  return new Update(new String.fromCharCode(newInt), 0, value.length);
}