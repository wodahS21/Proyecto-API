import 'package:flutter/material.dart';
import 'package:poketcg/models/card_model.dart';
import 'package:poketcg/widgets/musica.dart';

class CardScreen extends StatelessWidget {
  final pokecard card;
  const CardScreen({Key? key, required this.card}) : super(key: key);

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

  TextStyle getCustomTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 20.0,
      color: Colors.black,
      shadows: [
        Shadow(
          color: Color.fromARGB(255, 255, 255, 255),
          offset: Offset(1, 1),
          blurRadius: 3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: getBackgroundImageForType(card.types!.first),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  FadeInImage(
                    placeholder: const AssetImage('assets/images/pikachu.gif'),
                    image: NetworkImage(card.images!.large!),
                  ),
                  Text(
                    'ID:\n' + card.id! + '',
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Pokemon:' + card.name!,
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
                    'Ataque: ${card.attacks!.first.name}\n'
                    '${card.attacks!.first.text}',
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    '${card.attacks!.first.text}',
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Tipo: ' + card.types!.last,
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
