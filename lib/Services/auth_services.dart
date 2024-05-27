import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = "pokelogin.somee.com"; //? link de la api

  final storage = new FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'Password': password
    };

    //TODO: CunetasController si no funciona
    final url = Uri.http(_baseUrl, '/api/Cuentas/registrar');

    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodeResp['token']);
      return null;
    } else {
      decodeResp['error']['message'];
    }
    return null;
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.http(_baseUrl, 'api/Cuentas/Login');

    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('token')) {
      await storage.write(key: "token", value: decodeResp["token"]);
      return null;
    } else {
      return decodeResp["error"]["message"];
    }
  }

  Future logout() async {
    await storage.delete(key: "token");
  }

  Future<String> readToken() async {
    return await storage.read(key: "token") ?? '';
  }

  Future<String?> getUserId() async {
    try {
      final token = await readToken();
      print('Token: $token'); // Imprimir el token leído

      if (token != null) {
        print('Decoded Token: $token');

        // Decodificar el token para obtener la información del usuario
        final Map<String, dynamic> decodedToken = json.decode(
          ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))),
        );
        print('Decoded Token: $decodedToken'); // Imprimir el token decodificado

        // Devolver el correo electrónico del usuario
        if (decodedToken.containsKey('email')) {
          return decodedToken['email'];
        } else {
          print('No se encontró la clave "email" en el token');
        }
      } else {
        print('Token es nulo');
      }
    } catch (e) {
      print('Error al obtener el ID del usuario: $e');
    }
    return null; // Devolver null si no se encontró la información del usuario
  }

  Future<dynamic> favorito(String userName, String cardId) async {
    final token = await readToken();
    if (token == null) {
      print('Token is null');
      return null;
    }

    final Map<String, dynamic> authData = {
      "id": "",
      "userName": userName,
      "cardId": cardId
    };
    final url = Uri.http(_baseUrl, 'api/Cuentas/Favorito');

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final resp = await http.post(
      url,
      headers: headers,
      body: json.encode(authData),
    );

    if (resp.statusCode == 200) {
      final Map<String, dynamic> decodeResp = json.decode(resp.body);
      return decodeResp;
    } else {
      print('Error adding favorite: ${resp.statusCode}');
      return null;
    }
  }

  Future<dynamic> eliminarfavorito(String userName, String cardId) async {
    final token = await readToken();
    if (token == null) {
      print('Token es nulo');
      return null;
    }

    final Map<String, dynamic> authData = {
      "userName": userName,
      "cardId": cardId
    };
    final url = Uri.http(_baseUrl, 'api/Cuentas/EliminarFavorito');

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final resp = await http.post(
      url,
      headers: headers,
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    return decodeResp;
  }

  Future<dynamic> obtenerfavorito(String userName, String cardId) async {
    final token = await readToken();
    if (token == null) {
      print('Token es nulo');
      return null;
    }

    final Map<String, dynamic> authData = {
      "userName": userName,
      "cardId": cardId
    };
    final url = Uri.http(_baseUrl, 'api/Cuentas/ObtenerFavoritos');

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final resp = await http.post(
      url,
      headers: headers,
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    return decodeResp;
  }

  // Future<dynamic> obtenerfavorito(String userName, String cardId) async {
  //   final Map<String, dynamic> authData = {
  //     "userName": userName,
  //     "cardId": cardId
  //   };
  //   final url = Uri.http(_baseUrl, 'api/Cuentas/ObtenerFavoritos');

  //   final resp = await http.post(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(authData),
  //   );

  //   final Map<String, dynamic> decodeResp = json.decode(resp.body);

  //   return decodeResp;
  // }
}
