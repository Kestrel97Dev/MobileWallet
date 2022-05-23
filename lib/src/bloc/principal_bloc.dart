import 'dart:convert';
import 'package:billeteraflutter/src/models/principal_model.dart';

import 'dart:developer';

import 'package:billeteraflutter/src/repository/general/general_repository.dart';


class PrincipalBloc {
  final _repository = GeneralRepository();

  Future<Principal?> getPrincipal() async {
    print("entro al bloc");
    Principal? _principal = await _repository.getPrincipalAPI();
    return _principal;
  }

  
}
