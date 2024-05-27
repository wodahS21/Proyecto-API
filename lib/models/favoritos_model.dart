import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:poketcg/Services/auth_services.dart';

class FavoritesService {
  final String? userName;
  final String? cardId;
  final bool? fav;

  FavoritesService({
    this.userName,
    this.cardId,
    this.fav,
  });
}

Future<void> addFavorite(AuthService authService, String cardId) async {
  final String? userEmail = await authService.getUserId();
  final objeto = ParseObject('favoritos')
    ..set('UserName', userEmail)
    ..set('CardId', cardId)
    ..set('fav', true);
  try {
    await objeto.save();
    print('Added to favorites');
  } catch (e) {
    print(e.toString());
  }
}

Future<List<FavoritesService>?> readFavorite(
    AuthService authService, String cardId) async {
  final String? userEmail = await authService.getUserId();
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('favoritos'))
      ..whereEqualTo('UserName', userEmail);
    final response = await query.query();
    if (response.success &&
        response.results != null &&
        response.results!.isNotEmpty) {
      return response.results?.map((a) {
        return FavoritesService(
          userName: a.get('UserName') ?? '',
          cardId: a.get('CardId') ?? '',
          fav: a.get('fav') ?? '',
        );
      }).toList();
    } else {
      print(response.error?.message);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<void> deleteFavorite(AuthService authService, String cardId) async {
  final String? userEmail = await authService.getUserId();
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('favoritos'))
      ..whereEqualTo('CardId', cardId);
    final response = await query.query();
    if (response.success && response.results != null) {
      final objectDelete = response.results!.first;
      final deleteResponse = await objectDelete.delete();
      if (deleteResponse.success) {
        print('Deleted as successful');
      }
    }
  } catch (e) {
    print(e.toString());
  }
}
