import 'dart:convert';


import 'package:billeteraflutter/src/models/login_model.dart';
import 'package:billeteraflutter/src/models/session_model.dart';
import 'package:billeteraflutter/src/models/usuario_model.dart';

import 'dart:developer';

import 'package:billeteraflutter/src/repository/general/general_repository.dart';


class UsuariosBloc {
  final _repository = GeneralRepository();

  Future<Usuario?> getUsuarioById() async {
    Usuario? _usuario = await _repository.getUsuarioByIdAPI();
    return _usuario;
  }

  Future<bool> crearUsuario(Usuario usuario) async {
    return await _repository.crearUsuarioAPI(usuario);
  }

  Future<bool> editarUsuario(Usuario usuario) async {
    return await _repository.editarUsuarioAPI(usuario);
  }

  Future<bool> eliminarUsuario() async {
    return await _repository.eliminarUsuarioAPI();
  }

  
}
