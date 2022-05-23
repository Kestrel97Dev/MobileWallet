import 'dart:convert';
import 'dart:io';

import 'package:billeteraflutter/src/models/principal_model.dart';
import 'package:billeteraflutter/src/models/usuario_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class PrincipalApiService {
  final storage = const FlutterSecureStorage();
  String? token;
  String? uid;

  Future<Principal> getPrincipal() async {
    print("entro al API");
    Principal? _principal;
    token = await storage.read(key: "token");

    var res = await http.get(
      Uri.parse(
          "https://backend-seminario-uniajc.herokuapp.com/api/principal"),
      headers: {
        'x-token': token!,
      },
    );
    
    if (res.statusCode == 200) {
       var jsonData = json.decode(res.body);
      _principal = Principal.fromJson(jsonData);
    }

    return _principal!;
  }

  

}
