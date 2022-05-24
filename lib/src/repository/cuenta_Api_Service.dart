import 'dart:convert';
import 'dart:io';

import 'package:billeteraflutter/src/models/Cuenta_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class CuentaApiService {
  final storage = const FlutterSecureStorage();
  String? token;
  String? uid;

  Future<Cuenta> getCuentaById() async {
    Cuenta? _Cuenta;
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.get(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Cuentas/$uid"),
      headers: {
        'x-token': token!,
      },
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(res.body);
      _Cuenta = Cuenta.fromJson(jsonData['Cuenta']);
    }

    return _Cuenta!;
  }

  Future<bool> crearCuenta(Cuenta Cuenta) async {
    token = await storage.read(key: "token");
    var res = await http.post(
      Uri.parse("https://backend-seminario-uniajc.herokuapp.com/api/Cuentas/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(Cuenta.toJson()),
    );

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> editarCuenta(Cuenta Cuenta) async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");

    var res = await http.put(
        Uri.parse(
            "https://backend-seminario-uniajc.herokuapp.com/api/Cuentas/$uid"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'x-token': token!,
        },
        body: json.encode(Cuenta.toJson()));

    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> eliminarCuenta() async {
    token = await storage.read(key: "token");
    uid = await storage.read(key: "uid");
    var res = await http.delete(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/Cuentas/$uid"),
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
