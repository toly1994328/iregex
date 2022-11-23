class A {}

abstract class B {}

abstract class D {}

class C extends A with D, E, F implements B {}

mixin E {}

mixin F {}
