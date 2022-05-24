import 'dart:convert';
import 'dart:io';

import 'package:billeteraflutter/src/models/Ingreso_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class IngresoApiService {
  final storage = const FlutterSecureStorage();
  String? token;
  String? uid;

  Future<Ingreso> getIngresoById() async {
    Ingreso? _Ingreso;
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.get(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Ingresos/$uid"),
      headers: {
        'x-token': token!,
      },
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(res.body);
      _Ingreso = Ingreso.fromJson(jsonData['Ingreso']);
    }

    return _Ingreso!;
  }

  Future<bool> crearIngreso(Ingreso Ingreso) async {
    token = await storage.read(key: "token");
    var res = await http.post(
      Uri.parse("https://backend-seminario-uniajc.herokuapp.com/api/Ingresos/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(Ingreso.toJson()),
    );

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> editarIngreso(Ingreso Ingreso) async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.put(
        Uri.parse(
            "https://backend-seminario-uniajc.herokuapp.com/api/Ingresos/$uid"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'x-token': token!,
        },
        body: json.encode(Ingreso.toJson()));

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> eliminarIngreso() async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");
    var res = await http.delete(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Ingresos/$uid"),
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
