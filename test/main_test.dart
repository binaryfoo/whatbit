library main_test;

import 'package:unittest/unittest.dart';
import 'package:matcher/matcher.dart';
import 'package:mock/mock.dart';
import 'package:whatbit/component/up_down_key.dart';
import 'dart:html';

main() {
  group('UpDownKeyBound', () {
    test('should add one to hex a', () {
      var input = withInput("a", 0, 0);

      Update update = hexAdder(input, 1);

      expect(update.value, equals("b"));
      expect(update.selectionStart, equals(0));
      expect(update.selectionEnd, equals(1));
    });

    test('should add one to hex a', () {
      var input = withInput("a", 0, 0);

      Update update = hexAdder(input, -1);

      expect(update.value, equals("9"));
    });

    test('add overflows into high nibble when two characters selected', () {
      var input = withInput("0f", 0, 2);

      Update update = hexAdder(input, 1);

      expect(update.value, equals("10"));
    });

    test('add overflows into high nibble when three characters selected', () {
      var input = withInput("0ff", 0, 3);

      Update update = hexAdder(input, 1);

      expect(update.value, equals("100"));
    });
  });
}

_TextInput withInput(String value, int start, int end) {
  var input = new _TextInput();
  input.when(callsTo("get value")).thenReturn(value);
  input.when(callsTo("get selectionStart")).thenReturn(start);
  input.when(callsTo("get selectionEnd")).thenReturn(end);
  return input;
}

class _TextInput extends Mock implements InputElement {}
