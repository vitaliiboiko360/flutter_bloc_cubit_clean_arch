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

class TrafficLights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [LightCircle(), LightCircle(), LightCircle()],
    );
  }
}

class LightCircle extends CustomPaint {
  LightCircle({super.key}) : super(painter: LightCirclePainter());

  @override
  Size get size => Size(40, 40);
}

class LightCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(20, 20), 20, paint);
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
