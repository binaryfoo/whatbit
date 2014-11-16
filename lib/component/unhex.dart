library whatbit_unhexme_component;

import 'package:angular/angular.dart';
import 'package:hexbit/hexbit.dart';
import 'package:hexbit/math.dart';
import 'dart:html';

@Component(selector: 'unhex', templateUrl: 'unhex.html', cssUrl: 'unhex.css')
class UnHexMe {
  String hex = "";
  String lastHexServed = "";
  BitSet lastSetServed = new BitSet();
  Scope _scope;

  BitSet get bits {
    if (hex.length % 2 == 0 && lastHexServed != hex) {
      lastSetServed = Bit.fromHex(hex);
      lastHexServed = hex;
    }
    return lastSetServed;
  }

  bool get hasInput => hex != null && hex.length > 0;

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
    if (value.length > 0) {
      var start = input.selectionStart;
      var end = input.selectionEnd;
      if (start == end) {
        if (start == value.length) {
          start = value.length - 1;
          input.selectionStart = start;
        } else {
          end++;
          input.selectionEnd = end;
        }
      }
      if (end - start == 1) {
        var character = value.substring(start, end).toLowerCase();
        hex = value.substring(0, start) + Math.add(character, increment) + value.substring(end);
      }
    }
  }
}
