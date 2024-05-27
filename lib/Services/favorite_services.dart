import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poketcg/Services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  final String _baseUrl = "pokelogin.somee.com"; //? link de la api
  final SharedPreferences _sharedPreferences;

  FavoritesService(this._sharedPreferences);

  Future<void> toggleFavorite(BuildContext context, String cardId) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final String? userEmail = await authService.getUserId();

    if (userEmail == null) {
      print('El email del usuario es nulo');
      return;
    }

    final favoriteExists =
        _sharedPreferences.getBool('favorite_$cardId') ?? false;

    if (favoriteExists) {
      _sharedPreferences.remove('favorite_$cardId');
    } else {
      _sharedPreferences.setBool('favorite_$cardId', true);
    }

    final url = Uri.http(
        _baseUrl,
        favoriteExists
            ? '/api/Cuentas/EliminarFavorito'
            : '/api/Cuentas/Favorito');

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authService.readToken()}"
    };

    final body = json.encode({
      "userName": userEmail,
      "cardId": cardId,
    });

    try {
      final resp = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (resp.statusCode != 200 && resp.statusCode != 201) {
        print('Error adding favorite: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }

  bool isFavorite(String cardId) {
    return _sharedPreferences.getBool('favorite_$cardId') ?? false;
  }
}
