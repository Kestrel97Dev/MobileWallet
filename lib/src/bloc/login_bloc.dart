import 'package:billeteraflutter/src/models/login_model.dart';
import 'package:billeteraflutter/src/models/session_model.dart';

import 'dart:developer';

import 'package:billeteraflutter/src/repository/general/general_repository.dart';

class LoginBloc {
  final _repository = GeneralRepository();
  bool? _access;
  String? _message;
  bool _validate = true;

  bool get validate => _validate;

  Future<bool> validateLogin(String correo, String contrasena) async {
    _validate = false;
    Login _loginObject = Login(correo: correo, contrasena: contrasena);

    Session session = await _repository.validateLoginAPI(_loginObject);
    if (session.token != null) {
      DateTime timeSession = DateTime.now();
      // await _repository.saveLocalSessionStorage(
      //   session, timeSession.toString(),usuario
      // );
      _access = true;
    } else {
      _message = "Las credenciales son incorrectas";
      _access = false;
      _validate = true;
    }

    return _access!;
  }
}
