import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit_clean_arch/domain/traffic_light_domain.dart';
import 'package:flutter_bloc_cubit_clean_arch/state/traffic_light_state.dart';

class TrafficLightsPage extends StatelessWidget {
  const TrafficLightsPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Center(
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15,
            children: <Widget>[
              const Text('Traffic Lights'),
              TrafficLightsCubit(),
            ],
          ),
        ),
      ),
    );
  }
}

class TrafficLightsCubit extends StatelessWidget {
  const TrafficLightsCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => TrafficLightCubit(),
      child: Column(
        spacing: 10,
        children: [redLight(), yellowLight(), greenLight(), StartStopButton()],
      ),
    );
  }
}

var redLight = () => TrafficLightColor(TrafficLight.red);
var greenLight = () => TrafficLightColor(TrafficLight.green);
var yellowLight = () => TrafficLightColor(TrafficLight.yellow);

class TrafficLightColor extends StatelessWidget {
  TrafficLightColor(this.color, {super.key});
  TrafficLight color = TrafficLight.none;

  TrafficLight getColorToLight(TrafficLight currentColor) {
    if (color == currentColor) {
      return color;
    }
    return TrafficLight.none;
  }

  @override
  Widget build(BuildContext context) {
    final tlc = BlocProvider.of<TrafficLightCubit>(context, listen: true);
    return LightCircle(color: getColorToLight(tlc.state.trafficLight));
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
  bool shouldRepaint(LightCirclePainter oldDelegate) =>
      color != oldDelegate.color;
}

class StartStopButton extends StatefulWidget {
  const StartStopButton({super.key});
  @override
  State<StatefulWidget> createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  static final String startText = "Started";
  static final String stopText = "Paused";

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
    final tlc = BlocProvider.of<TrafficLightCubit>(context);
    return Padding(
      padding: EdgeInsetsGeometry.directional(top: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsetsGeometry.directional(start: 5, end: 5),
          ),
        ),
        onPressed: () {
          tlc.startStop();
          toggleState();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [_buttonIcon, Text(_buttonText)],
        ),
      ),
    );
  }
}
