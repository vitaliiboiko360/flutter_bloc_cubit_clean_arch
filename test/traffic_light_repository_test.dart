import 'package:test/test.dart';
import 'package:flutter_bloc_cubit_clean_arch/domain/traffic_light_domain.dart';
import 'package:flutter_bloc_cubit_clean_arch/repository/traffic_light_repository.dart';

void main() {
  test('getting data from repository', () {
    final TrafficLightRepository repo = MockTrafficLightRepository();

    final expectedData = {
      TrafficLight.red: 3,
      TrafficLight.yellow: 1,
      TrafficLight.green: 2,
    };

    expectedData.forEach((color, durationInSeconds) {
      expect(repo.getLightDuration(color).inSeconds, durationInSeconds);
    });
  });
}
