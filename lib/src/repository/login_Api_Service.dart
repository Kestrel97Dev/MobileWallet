import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:billeteraflutter/src/models/login_model.dart';

import 'package:billeteraflutter/src/models/session_model.dart';
import 'dart:developer';

class LoginApiService {
  Session? _session;

  int? _statusResponse;
  final storage = const FlutterSecureStorage();

  Future<Session> validateLogin(Login login) async {
    var res = await http.post(
        Uri.parse(
            "https://backend-seminario-uniajc.herokuapp.com/api/auth/login"),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(login.toJson()));

    var resBody = json.decode(res.body);
    _statusResponse = res.statusCode;
    _session = Session.fromJson(resBody);
    if (_statusResponse == 200) {
      await storage.write(key: "token", value: _session!.token!);
      await storage.write(key: "uid", value: resBody['usuario']['uid']);
    }

    return _session!;
  }
}
