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
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
          title: const Text("Centro Pokemon"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.admin_panel_settings_rounded),
                color: Colors.lightBlueAccent.shade400),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.fromARGB(255, 0, 255, 255),
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
          255, 14, 157, 228), // Cambia este color por el que desees
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
                  Text('ID: ' + card.id!),
                  Text('Pokemon: ' + card.name!),
                  Text('Artista: ' + card.artist!),
                  Text('Artista: ' + card.regulationMark.toString()),

                  Text(card.evolvesFrom ?? 'Primer Forma'),
                  Text(
                    card.evolvesTo != null
                        ? card.evolvesTo
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                        : "última evolución",
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
