library whatbit_byte_renderer;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(selector: 'bit', exportExpressions: const ['bit', 'value'])
class BitRenderer implements AttachAware {

  int _byteNumber;
  int _bitNumber;
  Element e;
  Scope scope;
  Animate animate;

  BitRenderer(this.e, this.scope, this.animate);

  @NgOneWay('bit')
  void set bitNumber(val) {
    _bitNumber = val;
  }

  @NgOneWay('byte')
  void set byteNumber(val) {
    _byteNumber = val;
  }

  void render(val) {
    e.text = val;
  }

  void attach() {
    scope.watch("bit($_byteNumber, $_bitNumber).value", (val, priorVal) {
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