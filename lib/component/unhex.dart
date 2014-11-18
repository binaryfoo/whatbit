library whatbit_unhexme_component;

import 'package:angular/angular.dart';
import 'package:hexbit/hexbit.dart';
import 'package:hexbit/math.dart';
import 'package:whatbit/component/hex_parser.dart';
import 'dart:html';

@Component(selector: 'unhex', templateUrl: 'unhex.html', cssUrl: 'unhex.css')
class UnHexMe {
  String _hex = "";
  List<Bit> _bits = []; // need to mutate to prevent change detection algorithm think everything has changed
  Scope _scope;

  String get hex => _hex;
  void set hex(String val) {
    _hex = val;
    if (val.length % 2 == 0) {
      _updateBits(val);
    }
  }

  _updateBits(String hex) {
    HexStringParser.updateBitList(hex, _bits);
  }

  List<Bit> get bits => _bits;

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

//@Decorator(selector: 'bit')
//class BitFormatter implements AttachAware {
//  Bit _b;
//  Element e;
//  Scope scope;
//  Animate animate;
//
//  BitFormatter(this.e, this.scope, this.animate);
//
//  @NgOneWay('b')
//  void set b(Bit val) {
//    _b = val;
//  }
//
//  void attach() {
//    scope.watch("bit.value", (value, oldValue) {
//      var bitVals = e.getElementsByClassName("bit-val");
//      if (bitVals.isEmpty) {
//        e.setInnerHtml('Byte ${_b.byteNumber} Bit ${_b.bitNumber} = <span class="bit-val">${_b.value}</span>');
//      } else {
//        animate.remove(bitVals).onCompleted.then((r) {
//          Element bitVal = e.ownerDocument.createElement("span");
//          bitVal.className = "bit-val";
//          bitVal.text = _b.value;
//          animate.insert([bitVal], e);
//        });
//      }
//    });
//  }
//
//}
