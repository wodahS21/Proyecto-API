import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poketcg/provider/card_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Color.fromARGB(255, 247, 4, 4),
          title: const Text(
            "Centro Pokémon",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), // Color del texto
              fontSize: 20, // Tamaño del texto
              fontWeight: FontWeight.bold, // Negrita
              fontStyle: FontStyle.italic, // Itálica
              letterSpacing: 1.5, // Espaciado entre letras
              shadows: [
                Shadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(2, 2),
                    blurRadius: 3)
              ], // Sombra del texto
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.admin_panel_settings_rounded),
              color: Colors.lightBlueAccent.shade400,
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.fromARGB(255, 39, 2, 107),
          child: cardProvider.cards.isNotEmpty
              ? CardList(
                  cardProvider: cardProvider,
                )
              : const Center(
                  child: Image(image: AssetImage('assets/images/pikachu.gif')),
                ),
        ));
  }
}

class CardList extends StatelessWidget {
  const CardList({super.key, required this.cardProvider});
  final CardProvider cardProvider;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(
          255, 6, 172, 238), // Cambia este color por el que desees
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.90,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: cardProvider.cards.length,
        itemBuilder: (context, index) {
          final card = cardProvider.cards[index];
          return GestureDetector(
            onTap: () {
              context.go('/card', extra: card);
            },
            child: Card(
              child: Column(
                children: [
                  FadeInImage(
                    placeholder: const AssetImage('assets/images/pikachu.gif'),
                    image: NetworkImage(card.images!.small!),
                  ),
                  Text(
                    'ID: ' + card.id!,
                    style: const TextStyle(
                      color: Colors.black, // Color del texto
                      fontWeight: FontWeight.bold, // Negrita
                      fontStyle: FontStyle.italic, // Itálica
                      letterSpacing: 0.5, // Espaciado entre letras
                      shadows: [
                        Shadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 2)
                      ], // Sombra del texto
                    ),
                  ),
                  Text(
                    'Pokemon: ' + card.name!,
                    style: const TextStyle(
                      color: Colors.black87, // Color del texto
                      fontWeight: FontWeight.bold, // Negrita
                      fontStyle: FontStyle.italic, // Itálica
                      letterSpacing: 0.5, // Espaciado entre letras
                      shadows: [
                        Shadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 2)
                      ], // Sombra del texto
                    ),
                  ),
                  Text(
                    'Artista: ' + card.artist!,
                    style: const TextStyle(
                      color: Colors.black87, // Color del texto
                      fontWeight: FontWeight.bold, // Negrita
                      fontStyle: FontStyle.italic, // Itálica
                      letterSpacing: 0.5, // Espaciado entre letras
                      shadows: [
                        Shadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 2)
                      ], // Sombra del texto
                    ),
                  ),
                  Text(
                    card.evolvesFrom ?? 'Primer Forma',
                    style: const TextStyle(
                      color: Colors.black, // Color del texto
                      fontWeight: FontWeight.bold, // Negrita
                      fontStyle: FontStyle.italic, // Itálica
                      letterSpacing: 0.5, // Espaciado entre letras
                      shadows: [
                        Shadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 2)
                      ], // Sombra del texto
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
                      color: Colors.black, // Color del texto
                      fontWeight: FontWeight.bold, // Negrita
                      fontStyle: FontStyle.italic, // Itálica
                      letterSpacing: 0.5, // Espaciado entre letras
                      shadows: [
                        Shadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 2)
                      ], // Sombra del texto
                    ),
                  ),

                  // FadeInImage(placeholder: 'assets/images/pikachu.gif', image: NetworkImage(card.images?.small!))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
