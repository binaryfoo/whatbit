library whatbit_byte_renderer;

import 'package:angular/angular.dart';
import 'package:whatbit/component/hex_parser.dart';
import 'dart:html';

@Component(selector: 'byte', templateUrl: 'byte_renderer.html', cssUrl: 'byte_renderer.css')
class ByteRenderer {

  Byte _byte;
  num number;
  List<int> bitIndices = new List.generate(8, (i) => 7 - i);

  @NgOneWay('byte')
  void set byte(Byte val) {
    _byte = val;
    number = _byte.number;
  }
  Byte get byte => _byte;
}

@Decorator(selector: 'bit')
class BitRenderer implements AttachAware {

  NgModel model;
  Element e;
  Scope scope;
  Animate animate;

  BitRenderer(this.e, this.scope, this.animate, this.model);

  void attach() {
    model.render = (val) {
      if (e.text == "") {
        e.text = val;
      } else {
        animate.addClass(e, "faded").onCompleted.then((r) {
          e.text = val;
          animate.removeClass(e, "faded");
        });
      }
    };
  }

}