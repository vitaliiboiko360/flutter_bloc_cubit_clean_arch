import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_cubit_clean_arch/domain/traffic_light_domain.dart';

class TrafficLightState {
  TrafficLightState();
  final TrafficLight _trafficLight = TrafficLight.none;
  TrafficLight get trafficLight => _trafficLight;
}

class TrafficLightCubit extends Cubit<TrafficLightState> {
  TrafficLightCubit() : super(TrafficLightState());
}
