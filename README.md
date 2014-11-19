Angulardart plaything that may have some practical use for folks who don't flip bits in their head on a daily basis.

Learning Scars
--------------

1. Collection equality. Use something like the [collection](https://pub.dartlang.org/packages/collection) pub package.

        Collections in Dart have no inherent equality. Two sets are not equal, even if they contain exactly the same objects as elements.

2. Don't forget hashCode(). Just like Java. The [quiver](https://pub.dartlang.org/packages/quiver) package might be useful.

3. Static getter generation by the transformer in pubspec.yaml. Don't understand the details yet.

4. Seems like you need to mutate a collection to allow nested elements within ng-repeat to be updated without remove/add cycle.