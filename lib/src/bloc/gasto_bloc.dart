import 'dart:convert';

import 'package:billeteraflutter/src/models/login_model.dart';
import 'package:billeteraflutter/src/models/session_model.dart';
import 'package:billeteraflutter/src/models/gasto_model.dart';

import 'dart:developer';

import 'package:billeteraflutter/src/repository/general/general_repository.dart';

class GastosBloc {
  final _repository = GeneralRepository();

  Future<Gasto?> getGastoById() async {
    Gastos? _gasto = await _repository.getUsuarioByIdAPI();
    return _gasto;
  }

  Future<bool> crearGastos(Gastos gastos) async {
    return await _repository.crearUsuarioAPI(usuario);
  }

  Future<bool> editarGastos(Gastos gastos) async {
    return await _repository.editarUsuarioAPI(gastos);
  }

  Future<bool> eliminarGastos() async {
    return await _repository.eliminarUsuarioAPI();
  }
}
