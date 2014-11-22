library whatbit_unhexme_component;

import 'package:angular/angular.dart';
import 'package:hexbit/hexbit.dart';
import 'package:quiver/iterables.dart' as q;
import 'dart:math';

@Component(selector: 'unhex',
  templateUrl: 'unhex.html',
  cssUrl: 'unhex.css')
class UnHexMe {
  String _hex = "";
  BitSet _bits = new BitSet();
  Scope _scope;

  String get hex => _hex;

  void set hex(String val) {
    _hex = val;
    _bits = Bit.fromHex(hex);
  }

  void replaceByte(int byteNumber, String twoHexChars) {
    var start = (byteNumber - 1) * 2;
    hex = _hex.substring(0, start) + twoHexChars.padLeft(2, '0') + _hex.substring(min(_hex.length, start + 2));
  }

  Bit bit(int byte, int bit) => _bits.bit(byte, bit);

  ByteView byte(int byte) => new ByteView(this, byte);

  int byteAsDecimal(int byte) => _bits.byte(byte);

  String byteAsCharacter(int byte) => new String.fromCharCode(byteAsDecimal(byte));

  Iterable<int> get bytes => q.range(1, _bits.byteCount + 1);

  Iterable<int> bitNumbers = q.range(8, 0, -1);

  bool get hasInput => _hex != null && _hex.length > 0;
}

class ByteView {
  UnHexMe source;
  int byteNumber;

  ByteView(this.source, this.byteNumber);

  String get decimal => source.byteAsDecimal(byteNumber).toString();

  set decimal(String val) {
    source.replaceByte(byteNumber, int.parse(val).toRadixString(16));
  }

  String get character => source.byteAsCharacter(byteNumber);

  set character(String val) {
    source.replaceByte(byteNumber, val != "" ? val.codeUnitAt(0).toRadixString(16) : "");
  }
}
