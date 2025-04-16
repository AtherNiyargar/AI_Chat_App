import 'package:ai_app/screens/home_page.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  ColorScheme? lightColorScheme;
  ColorScheme? darkColorScheme;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
          // sleep(Duration(seconds: 1));
          // setState(() {});
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme,
            secondaryHeaderColor: Colors.grey,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            secondaryHeaderColor: Colors.grey.shade800,
          ),
          home: HomePage(),
        );
      },
    );
  }
}
