import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

const titleApp = 'Flutter Bloc Cubit Clean Arch';
const titlePage = 'Flutter Traffic Light Page';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titleApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 48, 95, 165),
        ),
      ),
      home: const TrafficLightPage(title: titlePage),
    );
  }
}

class TrafficLightPage extends StatelessWidget {
  const TrafficLightPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: <Widget>[
            const Text('Traffic Lights'),
            Text('', style: Theme.of(context).textTheme.headlineMedium),
            StartStopButton(),
          ],
        ),
      ),
    );
  }
}

class TrafficLights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      ],
    );
  }
}

class StartStopButton extends StatefulWidget {
  StartStopButton({onPressed, super.key});
  VoidCallback onPressed = () {};
  @override
  State<StatefulWidget> createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  static String startText = "Start";
  static String stopText = "Stop";

  bool _isStarted = false;
  String _buttonText = startText;
  Icon _buttonIcon = Icon(Icons.play_arrow);

  void toggleState() {
    setState(() {
      _isStarted = !_isStarted;
      _buttonText = _isStarted ? stopText : startText;
      _buttonIcon = _isStarted ? Icon(Icons.pause) : Icon(Icons.play_arrow);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
        toggleState();
      },
      child: Row(spacing: 5, children: [_buttonIcon, Text(_buttonText)]),
    );
  }
}

enum TrafficLight {
  none('none'),
  red('red'),
  yellow('yellow'),
  green('green');

  const TrafficLight(this.name);
  final String name;
}

class TrafficLightState {
  TrafficLightState();
  final TrafficLight _trafficLight = TrafficLight.none;
  TrafficLight get trafficLight => _trafficLight;
}

class TrafficLightSequence {
  final List<TrafficLight> sequence = [
    TrafficLight.red,
    TrafficLight.yellow,
    TrafficLight.green,
    TrafficLight.yellow,
  ];
}

class TrafficLightCubit extends Cubit<TrafficLightState> {
  TrafficLightCubit() : super(TrafficLightState());
}
