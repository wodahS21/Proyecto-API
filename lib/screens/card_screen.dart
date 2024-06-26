import 'package:flutter/material.dart';
import 'package:poketcg/Services/auth_services.dart';
import 'package:poketcg/models/card_model.dart';
import 'package:poketcg/models/favoritos_model.dart';
import 'package:poketcg/widgets/musica.dart';
import 'package:provider/provider.dart';

class CardScreen extends StatefulWidget {
  final pokecard card;

  const CardScreen({Key? key, required this.card}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    //  _checkFavorite();
    Future.delayed(Duration.zero, () async {
      final authService = Provider.of<AuthService>(context, listen: false);
      final favorito = readFavorite(authService, widget.card.id!);
      //
      favorito.then((exists) {
        for (var elements in exists!) {
          if (elements.cardId == widget.card.id!) {
            setState(() {
              isFavorite = elements.fav!;
            });
          }
        }
      });
    });
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

  // void _checkFavorite() async {
  //   final authService = Provider.of<AuthService>(context, listen: false);
  //   final dynamic arguments = ModalRoute.of(context)!.settings.arguments;

  //   if (arguments is pokecard) {
  //     if (widget.card.id != null) {
  //       final String characterId = widget.card.id!;
  //       final String? userEmail = await authService.getUserId();

  //       if (userEmail != null) {
  //         try {
  //           final favorito =
  //               await authService.obtenerfavorito(userEmail, characterId);
  //           setState(() {
  //             isFavorite = favorito['data'].isNotEmpty;
  //           });
  //         } catch (e) {
  //           print('Error al verificar favoritos: $e');
  //         }
  //       } else {
  //         print('El email del usuario es nulo');
  //       }
  //     } else {
  //       print('El ID del personaje es nulo');
  //     }
  //   } else {
  //     print('Los argumentos no son de tipo Character');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context, listen: false);

    void checkFavorite() async {
      final cardId = widget.card.id!;
      final favorites = await readFavorite(authService, cardId);
      setState(() {
        isFavorite = favorites?.any((fav) => fav.cardId == cardId) ?? false;
      });
    }

    // Si aún no se ha verificado el favorito, hacerlo ahora
    if (!isFavorite) {
      checkFavorite();
    }
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(widget.card.name!),
        actions: [
          IconButton(
            onPressed: () async {
              final cardId = widget.card.id!;
              if (isFavorite) {
                await deleteFavorite(authService, cardId);
              } else {
                await addFavorite(authService, cardId);
              }
              // Actualizar el valor de isFavorite y verificar de nuevo
              checkFavorite();
            },
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: getBackgroundImageForType(widget.card.types!.first),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  FadeInImage(
                    placeholder: const AssetImage('assets/images/pikachu.gif'),
                    image: NetworkImage(widget.card.images!.large!),
                  ),
                  Text(
                    'ID:\n' + widget.card.id! + '',
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Pokemon:' + widget.card.name!,
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Artista: ' + widget.card.artist!,
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    widget.card.evolvesFrom ?? 'Primer Forma',
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    widget.card.evolvesTo != null
                        ? widget.card.evolvesTo
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                        : "última evolución",
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Ataque: ${widget.card.attacks!.first.name}\n'
                    '${widget.card.attacks!.first.text}',
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    '${widget.card.nationalPokedexNumbers!}',
                    style: getCustomTextStyle(),
                  ),
                  Text(
                    'Tipo: ' + widget.card.types!.last,
                    style: getCustomTextStyle(),
                  ),
                  FadeInImage(
                    placeholder: const AssetImage('assets/images/pikachu.gif'),
                    image: NetworkImage(widget.card.pokecardSet!.images!.logo!),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _addFavorite() async {
  //   final authService = Provider.of<AuthService>(context, listen: false);
  //   final dynamic arguments = ModalRoute.of(context)!.settings.arguments;

  //   if (arguments is pokecard) {
  //     if (widget.card.id != null) {
  //       final String characterId = widget.card.id!;
  //       final String? userEmail = await authService.getUserId();

  //       if (userEmail != null) {
  //         try {
  //           await authService.favorito(userEmail, characterId);
  //           setState(() {
  //             isFavorite = true;
  //           });
  //         } catch (e) {
  //           print('Error al agregar favorito: $e');
  //         }
  //       } else {
  //         print('El email del usuario es nulo');
  //       }
  //     } else {
  //       print('El ID del personaje es nulo');
  //     }
  //   } else {
  //     print('Los argumentos no son de tipo Character');
  //   }
  // }

  // void _removeFavorite() async {
  //   final authService = Provider.of<AuthService>(context, listen: false);
  //   final dynamic arguments = ModalRoute.of(context)!.settings.arguments;

  //   if (arguments is pokecard) {
  //     if (widget.card.id != null) {
  //       final String characterId = widget.card.id!;
  //       final String? userEmail = await authService.getUserId();

  //       if (userEmail != null) {
  //         try {
  //           await authService.eliminarfavorito(userEmail, characterId);
  //           setState(() {
  //             isFavorite = false;
  //           });
  //         } catch (e) {
  //           print('Error al eliminar favorito: $e');
  //         }
  //       } else {
  //         print('El email del usuario es nulo');
  //       }
  //     } else {
  //       print('El ID del personaje es nulo');
  //     }
  //   } else {
  //     print('Los argumentos no son de tipo Character');
  //   }
  // }
}
