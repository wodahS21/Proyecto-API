import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poketcg/models/card_model.dart';

class CardProvider with ChangeNotifier {
  final url = 'api.pokemontcg.io';
  final ak = '?key=f492b531-72eb-4bf3-9144-6329f8c01fc8';
  List<pokecard> cards = [];

  Future<void> getCards() async {
    final result = await http.get(Uri.https(url, "/v2/cards"));
    final response = cardsResposeFromJson(result.body);
    cards.addAll(response.data!);
    notifyListeners();
  }

  Future<void> getCardsid(String? cardId) async {
    final result = await http.get(Uri.https(url, "/v2/cards/$cardId"));
    final response = cardsResposeFromJson(result.body);
    cards.addAll(response.data!);
    notifyListeners();
  }
}
