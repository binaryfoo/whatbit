library unhexme_selectinput_component;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(selector: '[keep-selection]')
class KeepSelection implements AttachAware {

  Element inputElement;
  NgModel ngModel;
  Scope scope;

  KeepSelection(this.inputElement, this.ngModel, this.scope);

  void attach() {
    var realRender = ngModel.render;
    ngModel.render = (value) {
      InputElement input = inputElement;
      var selectionStart = input.selectionStart;
      var selectionEnd = input.selectionEnd;
      realRender(value);
      scope.rootScope.domWrite(() {
        input.selectionStart = selectionStart;
        input.selectionEnd = selectionEnd;
      });
    };
  }

}