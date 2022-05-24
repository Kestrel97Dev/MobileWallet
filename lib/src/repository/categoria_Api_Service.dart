import 'dart:convert';
import 'dart:io';

import 'package:billeteraflutter/src/models/Categoria_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class CategoriaApiService {
  final storage = const FlutterSecureStorage();
  String? token;
  String? uid;

  Future<Categoria> getCategoriaById() async {
    Categoria? _Categoria;
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.get(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Categorias/$uid"),
      headers: {
        'x-token': token!,
      },
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(res.body);
      _Categoria = Categoria.fromJson(jsonData['Categoria']);
    }

    return _Categoria!;
  }

  Future<bool> crearCategoria(Categoria Categoria) async {
    token = await storage.read(key: "token");
    var res = await http.post(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Categorias/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(Categoria.toJson()),
    );

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> editarCategoria(Categoria Categoria) async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.put(
        Uri.parse(
            "https://backend-seminario-uniajc.herokuapp.com/api/Categorias/$uid"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'x-token': token!,
        },
        body: json.encode(Categoria.toJson()));

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> eliminarCategoria() async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");
    var res = await http.delete(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Categorias/$uid"),
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
