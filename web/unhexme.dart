library unhexme;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:unhexme/component/unhex.dart';
import 'package:unhexme/component/keep_selection.dart';

class UnHexMeModule extends Module {
  UnHexMeModule() {
    bind(UnHexMe);
    bind(KeepSelection);
  }
}

void main() {
  applicationFactory()
    .addModule(new UnHexMeModule())
    .run();
}
