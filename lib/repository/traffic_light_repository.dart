import 'package:flutter_bloc_cubit_clean_arch/domain/traffic_light_domain.dart';

abstract interface class TrafficLightRepository {
  Duration getLightDuration(TrafficLight color);
  List<TrafficLight> getSequence();
}

class MockTrafficLightRepository implements TrafficLightRepository {
  const MockTrafficLightRepository();
  @override
  Duration getLightDuration(TrafficLight color) {
    int durationInSeconds;
    switch (color) {
      case TrafficLight.red:
        durationInSeconds = 3;
      case TrafficLight.yellow:
        durationInSeconds = 1;
      case TrafficLight.green:
        durationInSeconds = 2;
      default:
        durationInSeconds = 0;
    }
    return Duration(seconds: durationInSeconds);
  }

  @override
  List<TrafficLight> getSequence() => [
    TrafficLight.red,
    TrafficLight.yellow,
    TrafficLight.green,
    TrafficLight.yellow,
  ];
}
