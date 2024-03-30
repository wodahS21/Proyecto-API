import 'package:flutter/material.dart';
import 'package:poketcg/provider/card_provider.dart';
import 'package:poketcg/screens/card_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final cardProvider = Provider.of<CardProvider>(context, listen: false);
    cardProvider.getCards();
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro Pokémon'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.admin_panel_settings_rounded),
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: cardProvider.cards.isNotEmpty
            ? CardList(cardProvider: cardProvider)
            : const Center(
                child: Image(image: AssetImage('assets/images/pikachu.gif')),
              ),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  const CardList({Key? key, required this.cardProvider}) : super(key: key);
  final CardProvider cardProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 6, 172, 238),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.88,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: cardProvider.cards.length,
        itemBuilder: (context, index) {
          final card = cardProvider.cards[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/second', arguments: card);
            },
            child: Card(
              child: Container(
                // Envolver el Column con un Container
                color: getColorForType(
                    card.types!.first), // Cambiar el color de fondo aquí
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/pikachu.gif'),
                      image: NetworkImage(card.images!.small!),
                    ),
                    Text(
                      'ID: ' + card.id!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                    ),
                    Text(
                      'Pokemon: ' + card.name!,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                    ),
                    Text(
                      'Artista: ' + card.artist!,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                    ),
                    Text(
                      card.evolvesFrom ?? 'Primer Forma',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                    ),
                    Text(
                      card.evolvesTo != null
                          ? card.evolvesTo
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                          : "última evolución",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
