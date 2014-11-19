library whatbit_hex_parser;

import 'package:hexbit/hexbit.dart';
import 'dart:math';

class HexStringParser {

  /**
   * Updates [bytes]. Evil state mutation but not sure how else to manage the change detection algorithm
   * being based on object identity.
   */
  static updateBitList(String hex, List<Bit> bits) {
    int i = 0;
    Bit.fromHex(hex).forEach((newBit) {
      Bit oldBit = i < bits.length ? bits[i] : null;
      if (oldBit != null && oldBit.absoluteBitNumber == newBit.absoluteBitNumber) {
        oldBit.set = newBit.set;
      } else {
        if (oldBit != null) bits.removeAt(i);
        bits.add(newBit);
      }
      i++;
    });
    if (i != bits.length) {
      bits.removeRange(i, bits.length);
    }
  }

  /**
   * More state mutation.
   */
  static groupBitsIntoBytes(List<Byte> bytes, List<Bit> bits) {
    List<Bit> currentBits = [];
    int newByteCount = (bits.length/8).floor();
    if (newByteCount > bytes.length) {
      int currentByte = 0;
      for (var i = (bytes.length * 8); i < bits.length; i++) {
        Bit bit = bits[i];
        if (currentByte != bit.byteNumber && currentBits.isNotEmpty) {
          bytes.add(new Byte(currentByte, currentBits));
          currentBits = [];
        }
        currentByte = bit.byteNumber;
        currentBits.add(bit);
      }
      if (currentByte != 0 && currentBits.isNotEmpty) {
        bytes.add(new Byte(currentByte, currentBits));
      }
    } else {
      bytes.removeRange(newByteCount, bytes.length);
    }
  }

  static update(String hex, List<Byte> bytes, List<Bit> bits) {
    updateBitList(hex, bits);
    groupBitsIntoBytes(bytes, bits);
  }
}

class Byte {
  num number;
  List<Bit> bits;

  Byte(this.number, this.bits);

  String toString() => "Byte $num: bits $bits";

}