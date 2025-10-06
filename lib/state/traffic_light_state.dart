import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_cubit_clean_arch/domain/traffic_light_domain.dart';
import 'package:flutter_bloc_cubit_clean_arch/repository/traffic_light_repository.dart';

part 'traffic_light_state.freezed.dart';

const trafficLightRepository = MockTrafficLightRepository();

@freezed
class TrafficLightState with _$TrafficLightState {
  TrafficLightState({this.trafficLight = TrafficLight.none});
  final TrafficLight trafficLight;
}

class TrafficLightCubit extends Cubit<TrafficLightState> {
  TrafficLightCubit() : super(TrafficLightState()) {
    _timer = Timer.periodic(Duration(milliseconds: 30), (Timer timer) {
      _updateColor();
    });
    _stopwatch.start();
  }

  // for unit tests
  factory TrafficLightCubit.createForTests() {
    return TrafficLightCubit()..startStop();
  }

  int _position = -1;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _duration = Duration.zero;

  TrafficLight getNextActiveColor() => trafficLightRepository
      .getSequnce()[(++_position) % trafficLightRepository.getSequnce().length];

  void _updateColor() {
    Duration timeElapsed = _stopwatch.elapsed;
    if (timeElapsed < _duration) {
      return;
    }
    _stopwatch.reset();
    TrafficLight trafficLight = getNextActiveColor();
    _duration = trafficLightRepository.getLightDuration(trafficLight);
    emit(state.copyWith(trafficLight: trafficLight));
  }

  void startStop() =>
      _stopwatch.isRunning ? _stopwatch.stop() : _stopwatch.start();
}
