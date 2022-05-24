
import 'package:billeteraflutter/src/models/login_model.dart';

import 'package:billeteraflutter/src/models/session_model.dart';
import 'package:billeteraflutter/src/models/usuario_model.dart';
import 'package:billeteraflutter/src/repository/login_Api_Service.dart';
import 'dart:developer';

import 'package:billeteraflutter/src/repository/usuarios_Api_Service.dart';

class GeneralRepository {
  final loginApiService = LoginApiService();
  final usuarioApiService = UsuarioApiService();

  Future<Session> validateLoginAPI(Login login) {
    return loginApiService.validateLogin(login);
  }

  /*Usuario*/
  Future<Usuario> getUsuarioByIdAPI() {
    return usuarioApiService.getUsuarioById();
  }

  Future<bool> crearUsuarioAPI(Usuario usuario) {
    return usuarioApiService.crearUsuario(usuario);
  }

  Future<bool> editarUsuarioAPI(Usuario usuario) {
    return usuarioApiService.editarUsuario(usuario);
  }

  Future<bool> eliminarUsuarioAPI() {
    return usuarioApiService.eliminarUsuario();
  }

  /*Usuario*/
  
}
