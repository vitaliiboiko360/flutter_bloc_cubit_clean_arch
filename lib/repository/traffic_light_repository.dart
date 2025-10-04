import 'package:flutter_bloc_cubit_clean_arch/src/app.dart';

abstract interface class TrafficLightRepository {
  int getLightDuration(TrafficLight color);
}

class MockTrafficLightRepository implements TrafficLightRepository {
  @override
  int getLightDuration(TrafficLight color) {
    switch (color) {
      case TrafficLight.red:
        return 3;
      case TrafficLight.yellow:
        return 1;
      case TrafficLight.green:
        return 2;
      default:
        return 0;
    }
  }
}
