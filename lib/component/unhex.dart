library whatbit_unhexme_component;

import 'package:angular/angular.dart';
import 'package:hexbit/hexbit.dart';
import 'package:hexbit/math.dart';
import 'package:quiver/iterables.dart' as q;
import 'dart:html';
import 'dart:math';

@Component(selector: 'unhex',
  templateUrl: 'unhex.html',
  cssUrl: 'unhex.css',
  exportExpressions: const ['byteAsDecimal', 'byteAsCharacter'])
class UnHexMe {
  String _hex = "";
  BitSet _bits = new BitSet();
  Scope _scope;

  String get hex => _hex;
  void set hex(String val) {
    _hex = val;
    _bits = Bit.fromHex(hex);
  }

  Bit bit(int byte, int bit) => _bits.bit(byte, bit);
  int byteAsDecimal(int byte) => _bits.byte(byte);
  String byteAsCharacter(int byte) => new String.fromCharCode(byteAsDecimal(byte));

  Iterable<int> get bytes => q.range(1, _bits.byteCount + 1);

  Iterable<int> bitNumbers = q.range(8, 0, -1);

  bool get hasInput => _hex != null && _hex.length > 0;

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
