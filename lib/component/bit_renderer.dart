library whatbit_byte_renderer;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(selector: 'bit', exportExpressions: const ['bits', 'value'])
class BitRenderer implements AttachAware {

  int _bitNumber;
  Element e;
  Scope scope;
  Animate animate;

  BitRenderer(this.e, this.scope, this.animate);

  @NgOneWay('bit')
  void set bitNumber(val) {
    _bitNumber = val;
  }

  void render(val) {
    e.text = val;
  }

  void attach() {
    int index = _bitNumber - 1;
    scope.watch("byte.bits[$index].value", (val, priorVal) {
      if (priorVal == null || priorVal == "") {
        render(val);
      } else {
        animate.addClass(e, "faded").onCompleted.then((r) {
          render(val);
          animate.removeClass(e, "faded");
        });
      }
    });
  }

}