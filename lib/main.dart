import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa el paquete services.dart
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'package:poketcg/models/card_model.dart';
import 'package:poketcg/provider/card_provider.dart';
import 'package:poketcg/provider/login_form_provider.dart';
import 'package:poketcg/screens/card_screen.dart';
import 'package:poketcg/screens/favorites.dart';
import 'package:poketcg/screens/home_screen.dart';
import 'package:poketcg/Services/auth_services.dart';
import 'package:poketcg/Services/notifications_services.dart';
import 'package:poketcg/screens/checking.dart';
import 'package:poketcg/screens/login.dart';
import 'package:poketcg/screens/registro.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Bloquea la orientación en modo vertical
  ]);
  final keyApplicationId = 'ZSaUfLy2KIr3mn21sNeCrySumFSXMSe4unw8RQLl';
  final keyClientKey = 'amRaqqNIHNBFTzldEWVjSOoOROgkFj1oYBHC5sJQ';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (_) => LoginF_Pfrovider())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        initialRoute: 'login',
        routes: {
          '/second': (context) {
            final card = ModalRoute.of(context)!.settings.arguments as pokecard;
            return CardScreen(card: card);
          },
          'login': (_) => LoginPage(),
          'register': (_) => RegistroPage(),
          'home': (_) => HomeScreen(),
          'checking': (_) => CheckAuthScreen(),
          '/favorites': (_) => Favorites(),
        },
        scaffoldMessengerKey: NotificationsServices.messengerKey,
      ),
    );
  }
}
