library main_test;

import 'package:unittest/unittest.dart';
import 'package:matcher/matcher.dart';
import 'package:mock/mock.dart';
import 'package:whatbit/component/up_down_key.dart';
import 'dart:html';

main() {
  group('UpDownKeyBound hexAdder', () {
    test('should add one to hex a', () {
      Update update = hexAdder(withInput("a"), 1);
      expect(update.value, equals("b"));
    });

    test('should update selection', () {
      Update update = hexAdder(withInput("a", 0, 0), 1);
      expect(update.selectionStart, equals(0));
      expect(update.selectionEnd, equals(1));
    });

    test('should add one to hex a', () {
      Update update = hexAdder(withInput("a"), -1);
      expect(update.value, equals("9"));
    });

    test('add overflows into high nibble when two characters selected', () {
      Update update = hexAdder(withInput("0f"), 1);
      expect(update.value, equals("10"));
    });

    test('add overflows into high nibble when three characters selected', () {
      Update update = hexAdder(withInput("0ff"), 1);
      expect(update.value, equals("100"));
    });
  });

  group("UpDownKeyBound charAdder", () {
    test("a + 1 is b", () {
      expect(characterAdder(withInput("a"), 1).value, equals("b"));
    });
    test("z - 1 is y", () {
      expect(characterAdder(withInput("z"), -1).value, equals("y"));
    });

    test('should update selection', () {
      Update update = characterAdder(withInput("a", 0, 0), 1);
      expect(update.selectionStart, equals(0));
      expect(update.selectionEnd, equals(1));
    });
  });

  group("UpDownKeyBound intAdder", () {
    test("1 + 1 is 2", () {
      expect(integerAdder(withInput("1"), 1).value, equals("2"));
    });

    test("1 - 1 is 0", () {
      expect(integerAdder(withInput("1"), -1).value, equals("0"));
    });

    test("0 - 1 is 255", () {
      expect(integerAdder(withInput("0"), -1).value, equals("255"));
    });

    test("255 + 1 is 0", () {
      expect(integerAdder(withInput("255"), 1).value, equals("0"));
    });

    test('should update selection', () {
      Update update = integerAdder(withInput("245", 0, 0), 1);
      expect(update.selectionStart, equals(0));
      expect(update.selectionEnd, equals(3));
    });
  });
}

_TextInput withInput(String value, [int start = 0, int end]) {
  if (end == null) {
    end = value.length;
  }
  var input = new _TextInput();
  input.when(callsTo("get value")).thenReturn(value);
  input.when(callsTo("get selectionStart")).thenReturn(start);
  input.when(callsTo("get selectionEnd")).thenReturn(end);
  return input;
}

class _TextInput extends Mock implements InputElement {}
