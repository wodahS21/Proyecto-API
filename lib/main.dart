import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa el paquete services.dart

import 'package:poketcg/models/card_model.dart';
import 'package:poketcg/provider/card_provider.dart';
import 'package:poketcg/screens/card_screen.dart';
import 'package:poketcg/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Bloquea la orientación en modo vertical
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Poketcg',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/second': (context) {
            final card = ModalRoute.of(context)!.settings.arguments as pokecard;
            return CardScreen(card: card);
          },
        },
      ),
    );
  }
}
