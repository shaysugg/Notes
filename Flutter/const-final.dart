//can be used on global values
const int five = 5;

class FiveWrapper {
  /// can't use const on instance class
  // const five = 5;

  /// can use const only as **static**
  static const five = 5;
}

class Cordinate {
  final int x, y;

  const Cordinate(this.x, this.y);
}

void ExampleOfCordinate() {
  const center = const Cordinate(0, 0);

  center = const Cordinate(-1, -1);

  Cordinate someCordinate = const Cordinate(-10, -10);

  someCordinate = const Cordinate(-20, -20);
}
