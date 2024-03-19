import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poketcg/provider/card_provider.dart';
import 'package:poketcg/screens/card_screen.dart';
import 'package:poketcg/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());
final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
            path: 'card',
            builder: (context, state) {
              final card = state.extra as Card;
              return CardScreen(
                card: card,
              );
            })
      ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp.router(
        title: 'Pokemon TCG',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
