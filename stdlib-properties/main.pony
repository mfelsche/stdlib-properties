use "ponytest"
use "ponycheck"


actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() => None

  fun tag tests(test: PonyTest) =>
    test(IntPairUnitTest(DivRemProperty))
    test(IntPairUnitTest(FldModProperty))

class iso DivRemProperty is IntPairProperty
  fun name(): String => "builtin/integer/divrem"

  fun ref int_property[T: (Int & Integer[T] val)](x: T, y: T, h: PropertyHelper) =>
    """
    (x / y) * y + (x % y) == x
    """
    let res = ((x / y) * y) + (x % y)
    h.assert_eq[T](res, x)

class iso FldModProperty is IntPairProperty
  fun name(): String => "builtin/integer/fldmod"

  fun ref int_property[T: (Int & Integer[T] val)](x: T, y: T, h: PropertyHelper) =>
    """
    (x fld y) * y + (x %% y) == x
    """
    let res = (x.fld(y) * y) + (x %% y)
    h.assert_eq[T](res, x)
