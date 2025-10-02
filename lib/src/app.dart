import 'dart:async';

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
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15,
            children: <Widget>[
              const Text('Traffic Lights'),
              TrafficLights(),
              StartStopButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TrafficLights extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TrafficLightsState();
}

class TrafficLightsState extends State<TrafficLights> {
  Timer? _timer;
  int _seconds = -1;
  bool isActiveRed = false;
  bool isActiveYellow = false;
  bool isActiveGreen = false;

  void changeActiveColor(int numberOfSeconds) {
    switch (numberOfSeconds) {
      case 0:
        isActiveRed = true;
        isActiveGreen = isActiveYellow = false;
      case 1:
        isActiveYellow = true;
        isActiveRed = isActiveGreen = false;
      case 2:
        isActiveGreen = true;
        isActiveYellow = isActiveRed = false;
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _seconds = ((_seconds + 1) % 3);
      setState(() {
        changeActiveColor(_seconds);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        trafficLight(TrafficLight.red, isActiveRed),
        trafficLight(TrafficLight.yellow, isActiveYellow),
        trafficLight(TrafficLight.green, isActiveGreen),
      ],
    );
  }
}

var redLight = () => TrafficLightColor(TrafficLight.red);
var greenLight = () => TrafficLightColor(TrafficLight.green);
var yellowLight = () => TrafficLightColor(TrafficLight.yellow);
var noneLight = () => TrafficLightColor(TrafficLight.none);
var trafficLight = (TrafficLight lightColor, bool isActive) =>
    isActive ? TrafficLightColor(lightColor) : noneLight();

class TrafficLightColor extends StatelessWidget {
  TrafficLightColor(this.color, {super.key});
  TrafficLight color = TrafficLight.none;
  @override
  Widget build(BuildContext context) {
    return LightCircle(color: color);
  }
}

class LightCircle extends CustomPaint {
  LightCircle({required color, super.key})
    : super(painter: LightCirclePainter(color));

  @override
  Size get size => Size(40, 40);
}

class LightCirclePainter extends CustomPainter {
  LightCirclePainter(this.color);
  TrafficLight color;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(20, 20), 20, paint);

    if (color != TrafficLight.none) {
      Color fillColor;
      switch (color) {
        case TrafficLight.red:
          fillColor = Colors.red;
        case TrafficLight.green:
          fillColor = Colors.green;
        case TrafficLight.yellow:
          fillColor = Colors.yellow;
        default:
          fillColor = Colors.white;
      }
      Paint fillPaint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(20, 20), 20, fillPaint);
    }
  }

  @override
  bool shouldRepaint(LightCirclePainter oldDelegate) => false;
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
      style: ButtonStyle(
        alignment: AlignmentGeometry.center,
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsetsGeometry.directional(start: 5, end: 5),
        ),
      ),
      onPressed: () {
        widget.onPressed();
        toggleState();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [_buttonIcon, Text(_buttonText)],
      ),
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
