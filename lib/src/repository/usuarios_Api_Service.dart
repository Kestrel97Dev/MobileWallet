import 'dart:convert';
import 'dart:io';

import 'package:billeteraflutter/src/models/usuario_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class UsuarioApiService {
  final storage = const FlutterSecureStorage();
  String? token;
  String? uid;

  Future<Usuario> getUsuarioById() async {
    Usuario? _usuario;
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.get(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/usuarios/$uid"),
      headers: {
        'x-token': token!,
      },
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(res.body);
      _usuario = Usuario.fromJson(jsonData['usuario']);
    }

    return _usuario!;
  }

  Future<bool> crearUsuario(Usuario usuario) async {
    token = await storage.read(key: "token");
    var res = await http.post(
      Uri.parse("https://backend-seminario-uniajc.herokuapp.com/api/usuarios/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(usuario.toJson()),
    );

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> editarUsuario(Usuario usuario) async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.put(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/usuarios/$uid"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'x-token': token!,
      },
        body: json.encode(usuario.toJson()));
    
    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> eliminarUsuario() async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");
    var res = await http.delete(
      Uri.parse(
         "https://backend-seminario-uniajc.herokuapp.com/api/usuarios/$uid"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'x-token': token!,
        },
    );

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

}
