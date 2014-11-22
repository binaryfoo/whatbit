library whatbit;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular/animate/module.dart';
import 'package:whatbit/component/unhex.dart';
import 'package:whatbit/component/bit_renderer.dart';
import 'package:whatbit/component/up_down_key.dart';

class UnHexMeModule extends Module {
  UnHexMeModule() {
    install(new AnimationModule());
    bind(UnHexMe);
    bind(BitRenderer);
    bind(UpDownKeyBound);
  }
}

void main() {
  applicationFactory()
    .addModule(new UnHexMeModule())
    .run();
}
