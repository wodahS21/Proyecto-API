import 'package:flutter/material.dart';
import 'package:poketcg/models/card_model.dart';

class CardScreen extends StatelessWidget {
  final pokecard card;
  const CardScreen({Key? key, required this.card}) : super(key: key);

  Color getColorForType(String? type) {
    switch (type) {
      case 'Colorless':
        return Color.fromARGB(255, 255, 255, 255);

      case 'Darkness':
        return Color.fromARGB(255, 50, 31, 80);

      case 'Dragon':
        return Color.fromARGB(255, 69, 75, 20);

      case 'Fairy':
        return Color.fromARGB(255, 209, 2, 192);

      case 'Fighting':
        return Color.fromARGB(255, 218, 145, 11);

      case 'Fire':
        return Color.fromARGB(255, 255, 0, 0);

      case 'Grass':
        return Color.fromARGB(255, 8, 161, 3);

      case 'Lightning':
        return Color.fromARGB(255, 255, 230, 0);

      case 'Metal':
        return Color.fromARGB(255, 118, 122, 116);

      case 'Psychic':
        return Color.fromARGB(255, 165, 6, 112);

      case 'Water':
        return Color.fromARGB(255, 9, 13, 202);

      default:
        return Colors.black;
    }
  }

  TextStyle getCustomTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 0.5,
      shadows: [
        Shadow(
          color: Colors.grey,
          offset: Offset(1, 1),
          blurRadius: 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade600,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(card.name!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.admin_panel_settings_rounded),
            color: Colors.lightBlueAccent.shade400,
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            child: Container(
              // Aquí se envuelve el Column con un Container
              color: getColorForType(card.types!
                  .first), //obtener el color de fondo aquí dependiendo del tipo de la carta
              child: Column(
                children: [
                  FadeInImage(
                    placeholder: const AssetImage('assets/images/pikachu.gif'),
                    image: NetworkImage(card.images!.large!),
                  ),
                  Text(
                    'ID: ' + card.id!,
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Pokemon: ' + card.name!,
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Artista: ' + card.artist!,
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    card.evolvesFrom ?? 'Primer Forma',
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    card.evolvesTo != null
                        ? card.evolvesTo
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                        : "última evolución",
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Pokemon: ' + card.rules!.toString(),
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Tipo: ' + card.types!.first,
                    style: getCustomTextStyle(),
                  ),
                  FadeInImage(
                    placeholder: const AssetImage('assets/images/pikachu.gif'),
                    image: NetworkImage(card.pokecardSet!.images!.logo!),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
