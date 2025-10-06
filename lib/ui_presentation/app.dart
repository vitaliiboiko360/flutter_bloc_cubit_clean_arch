import 'package:flutter/material.dart';
import 'package:flutter_bloc_cubit_clean_arch/ui_presentation/traffic_lights_page_details.dart';

const titleApp = 'Flutter Bloc Cubit Clean Arch';
const titlePage = 'Flutter Traffic Lights Page';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: titleApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 48, 95, 165),
        ),
      ),
      home: const TrafficLightsPage(title: titlePage),
    );
  }
}
