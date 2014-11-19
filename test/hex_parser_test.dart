library hex_parser_test;

import "package:whatbit/component/hex_parser.dart";
import "package:hexbit/hexbit.dart";
import "package:unittest/unittest.dart";
import "package:matcher/matcher.dart";

main() {
  List<Byte> bytes = [];
  List<Bit> bits = [];

  test("nothing to two bytes then back to nothing", () {
    HexStringParser.update("ff00", bytes, bits);
    expect(bytes, hasLength(2));
    expect(bits, hasLength(16));

    HexStringParser.update("", bytes, bits);

    expect(bytes, hasLength(0));
    expect(bits, hasLength(0));
  });

  test("add one byte", () {
    HexStringParser.update("aa", bytes, bits);
    HexStringParser.update("aabb", bytes, bits);

    expect(bytes, hasLength(2));
    expect(bits, hasLength(16));
  });

  test("remove one byte", () {
    HexStringParser.update("aabb", bytes, bits);
    HexStringParser.update("aa", bytes, bits);

    expect(bytes, hasLength(1));
    expect(bits, hasLength(8));
  });

  test("append byte to bit list", () {
    HexStringParser.updateBitList("aa", bits);
    HexStringParser.updateBitList("aabb", bits);
    expect(bits, equals(Bit.fromHex("aa").union(Bit.fromHex("bb", 2)).toList()));
  });

  test("prepend byte to bit list", () {
    HexStringParser.updateBitList("ff", bits);
    HexStringParser.updateBitList("00ff", bits);
    expect(bits, equals(Bit.fromHex("00").union(Bit.fromHex("ff", 2)).toList()));
  });
}