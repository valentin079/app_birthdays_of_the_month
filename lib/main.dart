import 'package:atividade2/screens/MyHomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aniversariantes do mês',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF000000, // Valor hexadecimal para a cor preta
          <int, Color>{
            50: Colors.black,
            100: Colors.black,
            200: Colors.black,
            300: Colors.black,
            400: Colors.black,
            500: Colors.black,
            600: Colors.black,
            700: Colors.black,
            800: Colors.black,
            900: Colors.black,
          },
        ),
      ),
      home: MyHomePage(title: 'Aniversariantes do mês'),
    );
  }
}
