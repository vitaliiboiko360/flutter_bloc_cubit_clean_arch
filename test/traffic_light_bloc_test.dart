import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_cubit_clean_arch/domain/traffic_light_domain.dart';
import 'package:flutter_bloc_cubit_clean_arch/state/traffic_light_state.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  late TrafficLightCubit trafficLightCubit;

  setUp(() {
    trafficLightCubit = TrafficLightCubit.createForTests();
  });

  test('initial state', () {
    expect(trafficLightCubit.state.trafficLight, TrafficLight.none);
  });
  blocTest(
    'changed state',
    build: () => trafficLightCubit,
    act: (bloc) async {
      bloc.updateColor();
      await Future.delayed(Duration(seconds: 1));
    },
    verify: (bloc) =>
        bloc.state.trafficLight == TrafficLight.red ||
        bloc.state.trafficLight == TrafficLight.yellow ||
        bloc.state.trafficLight == TrafficLight.green,
  );
}
