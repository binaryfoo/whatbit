Angulardart plaything that may have some practical use for folks who don't flip bits in their head on a daily basis.

Learning Scars
--------------

1. Collection equality. Use something like the [collection](https://pub.dartlang.org/packages/collection) pub package.

        Collections in Dart have no inherent equality. Two sets are not equal, even if they contain exactly the same objects as elements.

2. Don't forget hashCode(). Just like Java. The [quiver](https://pub.dartlang.org/packages/quiver) package might be useful.

3. Angular requires build process tweak (a transformer in pubspec.yaml). One job it does is generate code stubs to avoid using reflection in expressions
passed to scope.watch. It scans .html looking for expressions. It also allows extra annotations in the .dart source for cases where this might fail
(see packages/angular/tools/source_metadata_extractor.dart).
A mention on [stack overflow](http://stackoverflow.com/questions/26427646/pretty-much-simple-things-in-dartangular-1-0-dart-1-7).
An error like this is a clue the build process isn't generating a code stub for an expression:

        Missing getter: (o) => o.xxx

4. Seems like you need to mutate a collection to allow nested elements within ng-repeat to be updated without remove/add cycle.

