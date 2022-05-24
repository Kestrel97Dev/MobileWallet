import 'dart:convert';
import 'dart:io';

import 'package:billeteraflutter/src/models/Gasto_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class GastoApiService {
  final storage = const FlutterSecureStorage();
  String? token;
  String? uid;

  Future<Gasto> getGastoById() async {
    Gasto? _Gasto;
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.get(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Gastos/$uid"),
      headers: {
        'x-token': token!,
      },
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(res.body);
      _Gasto = Gasto.fromJson(jsonData['Gasto']);
    }

    return _Gasto!;
  }

  Future<bool> crearGasto(Gasto Gasto) async {
    token = await storage.read(key: "token");
    var res = await http.post(
      Uri.parse("https://backend-seminario-uniajc.herokuapp.com/api/Gastos/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(Gasto.toJson()),
    );

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> editarGasto(Gasto Gasto) async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.put(
        Uri.parse(
            "https://backend-seminario-uniajc.herokuapp.com/api/Gastos/$uid"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'x-token': token!,
        },
        body: json.encode(Gasto.toJson()));

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> eliminarGasto() async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");
    var res = await http.delete(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Gastos/$uid"),
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
