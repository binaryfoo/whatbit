library whatbit_byte_formatter;

import 'package:angular/angular.dart';
import 'package:hexbit/hexbit.dart';
import 'package:whatbit/component/hex_parser.dart';

@Formatter(name: 'groupToBytes')
class GroupBytesFormatter implements Function {
  List<Byte> call(List<Bit> bits) {
    List<Byte> bytes = [];
    HexStringParser.groupBitsIntoBytes(bytes, bits);
    return bytes;
  }
}