import 'package:flutter/material.dart';
import 'package:poketcg/provider/card_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:poketcg/screens/card_screen.dart';
import 'package:poketcg/Services/auth_services.dart';
import 'package:poketcg/widgets/drawer.dart';
import 'package:poketcg/widgets/musica.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void _logout(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.logout();
    Navigator.pushReplacementNamed(context, 'login');
  }

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
        // leading: IconButton(
        //   icon: Icon(Icons.logout),
        //   onPressed: () => _logout(context),
        // ),
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
      drawer: const DrawerHome(),
    );
  }
}

class CardList extends StatelessWidget {
  const CardList({Key? key, required this.cardProvider}) : super(key: key);
  final CardProvider cardProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAA2AGpHBZVdrT2_HloL4HVEmo9xCLKFq76MJV3TzG2w&s'), // Imagen por defecto
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 0.80,
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: getBackgroundImageForType(card.types!
                            .first), // Obtener la imagen de fondo según el tipo
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '' + card.name!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                  color: Color.fromARGB(255, 255, 230, 0),
                                  offset: Offset(1, 1),
                                  blurRadius: 2)
                            ],
                          ),
                        ),
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
        ],
      ),
    );
  }

  ImageProvider getBackgroundImageForType(String type) {
    switch (type) {
      case 'Colorless':
        return NetworkImage(
            'https://pokemongohub.net/wp-content/uploads/2019/05/Normal-Types.jpg');
      case 'Darkness':
        return NetworkImage(
            'https://i.pinimg.com/736x/4b/d1/42/4bd14212ec7c1c98a2bb820e9201e006.jpg');
      case 'Dragon':
        return NetworkImage(
            'https://pokemongohub.net/wp-content/uploads/2019/01/Dragon-Types-1.jpg');
      case 'Fairy':
        return NetworkImage(
            'https://pokemongohub.net/wp-content/uploads/2019/02/Fairy-Types-1024x576.jpg');
      case 'Fighting':
        return NetworkImage(
            'https://i.pinimg.com/originals/1a/73/1d/1a731dfeef1583caabefb12af75c621d.png');
      case 'Fire':
        return NetworkImage(
            'https://i.pinimg.com/originals/ea/49/59/ea49597d176612580fbbac7185b38dce.jpg');
      case 'Grass':
        return NetworkImage(
            'https://i.pinimg.com/originals/cd/f0/65/cdf065dd059561bfc53d34db0fda588e.jpg');
      case 'Lightning':
        return NetworkImage(
            'https://pokemongohub.net/wp-content/uploads/2019/01/Electric-Types.jpg');
      case 'Metal':
        return NetworkImage(
            'https://c4.wallpaperflare.com/wallpaper/122/545/285/pokemon-steel-pokemon-steelix-wallpaper-preview.jpg');
      case 'Psychic':
        return NetworkImage(
            'https://pokemongohub.net/wp-content/uploads/2019/01/Psychic-Types.jpg');
      case 'Water':
        return NetworkImage(
            'https://pokemongohub.net/wp-content/uploads/2019/01/Water-Types.jpg');
      default:
        return NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAA2AGpHBZVdrT2_HloL4HVEmo9xCLKFq76MJV3TzG2w&s'); // Imagen por defecto en caso de tipo desconocido
    }
  }
}
