import 'package:flutter/material.dart';
import 'package:poketcg/provider/card_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:poketcg/screens/card_screen.dart';
import 'package:poketcg/widgets/musica.dart';
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
        backgroundColor: Color.fromARGB(255, 219, 1, 1), // Rojo Profundo

        elevation: 0, // Quita la sombra de la AppBar
        leading: IconButton(
          icon: Icon(Icons.menu), // Icono para mostrar el menú
          onPressed: () {
            // Agrega la funcionalidad para mostrar el menú aquí
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search), // Icono para mostrar la búsqueda
            onPressed: () {
              // Agrega la funcionalidad para realizar la búsqueda aquí
            },
          ),
        ],
        title: const Stack(
          children: [
            // Texto sombreado
            Positioned(
              left: 2, // Ajusta la posición del sombreado
              top: 2, // Ajusta la posición del sombreado
              child: Text(
                'Centro Pokémon',
                style: TextStyle(
                  fontFamily: 'Pokemon',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.black, // Color del sombreado
                ),
              ),
            ),
            // Texto principal
            Text(
              'Centro Pokémon',
              style: TextStyle(
                fontFamily: 'Pokemon',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.yellow, // Color del texto principal
              ),
            ),
          ],
        ),
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
    return Scaffold(
      // color: const Color.fromARGB(255, 6, 172, 238),
      // child: GridView.builder(
      body: Stack(children: [
        Positioned.fill(
          child: Container(
            color: const Color.fromARGB(255, 6, 172, 238),
          ),
        ),
        GridView.builder(
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
        Musica(),
        //       Positioned(
        //         bottom: 16, // Ajusta la distancia desde la parte inferior
        //         right: 16, // Ajusta la distancia desde la derecha
        //         child: FloatingActionButton(

        //           onPressed: () async {
        //               if (playing) {
        //                 await stopm('images/RedBlue.mp3');
        //               } else {
        //                 await playm('images/RedBlue.mp3');
        //                 //await audioPlayer.play(UrlSource('https://www.youtube.com/watch?v=XiV7hwfLXGE'));
        //               }
        //           },
        //           child: Icon(Icons.add), // Puedes ajustar el icono aquí
        // ),
        //       ),
      ]),
    );
  }
}

Color getColorForType(String? type) {
  switch (type) {
    case 'Colorless':
      return const Color.fromARGB(255, 255, 255, 255);
    case 'Darkness':
      return const Color.fromARGB(255, 50, 31, 80);
    case 'Dragon':
      return const Color.fromARGB(255, 69, 75, 20);
    case 'Fairy':
      return const Color.fromARGB(255, 209, 2, 192);
    case 'Fighting':
      return const Color.fromARGB(255, 218, 145, 11);
    case 'Fire':
      return const Color.fromARGB(255, 255, 0, 0);
    case 'Grass':
      return const Color.fromARGB(255, 8, 161, 3);
    case 'Lightning':
      return const Color.fromARGB(255, 255, 230, 0);
    case 'Metal':
      return Color.fromARGB(151, 155, 147, 129);
    case 'Psychic':
      return const Color.fromARGB(255, 165, 6, 112);
    case 'Water':
      return const Color.fromARGB(255, 9, 13, 202);
    default:
      return Colors.black;
  }
}
