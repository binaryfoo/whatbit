library whatbit_byte_renderer;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(selector: 'bit')
class BitRenderer {

  NgModel model;
  Element e;
  Animate animate;

  BitRenderer(this.e, this.model, this.animate) {
    model.render = (value) {
      if (e.text == "") {
        render(value);
      } else {
        animate.addClass(e, "faded").onCompleted.then((r) {
          render(value);
          animate.removeClass(e, "faded");
        });
      }
    };
  }

  void render(val) {
    e.text = val == null ? "" : val;
  }

}