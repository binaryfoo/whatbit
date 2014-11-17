library whatbit;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular/animate/module.dart';
import 'package:whatbit/component/unhex.dart';
import 'package:whatbit/component/keep_selection.dart';

class UnHexMeModule extends Module {
  UnHexMeModule() {
    install(new AnimationModule());
    bind(UnHexMe);
    bind(KeepSelection);
    bind(BitFormatter);
  }
}

void main() {
  applicationFactory()
    .addModule(new UnHexMeModule())
    .run();
}
