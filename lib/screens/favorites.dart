import 'package:flutter/material.dart';
import 'package:poketcg/Services/auth_services.dart';
import 'package:poketcg/models/favoritos_model.dart';
import 'package:poketcg/provider/card_provider.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<FavoritesService>? userdata;
  bool dataLoaded = false;
  @override
  void initState() {
    super.initState();
    getId();
  }

  Future<void> getId() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final a = await drawFavorite(authService);
    setState(() {
      userdata = a;
    });
    await Future.wait(userdata!.map((fav) async {
      await context.read<CardProvider>().getCardsid(fav.cardId);
    }));

    // Datos cargados, actualizamos el estado del widget
    setState(() {
      dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final postMnt = context.read<CardProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 40, 70, 180),
                Color.fromARGB(255, 175, 0, 150)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: userdata?.length ?? 0,
        itemBuilder: (context, index) {
          if (userdata != null && userdata!.isNotEmpty) {
            final pokeId = userdata![index].cardId;
            final poke = postMnt.cards.elementAt(pokeId);

            return Column(
              children: [
                ListTile(
                  title: Text(poke.name ?? 'Loading...'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/second',
                      arguments: context,
                    );
                  },
                ),
                const Divider(height: 5, thickness: 1)
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
