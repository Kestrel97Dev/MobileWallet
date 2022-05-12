import 'package:vacunacion/src/models/login_model.dart';
import 'package:vacunacion/src/models/session_model.dart';
import 'package:vacunacion/src/repository/enfermeros/enfermeros_repository.dart';
import 'dart:developer';

class LoginBloc{

  final _repository = EnfermerosRepository();
  bool? _access;
  String? _message;

  Future<bool> validateLogin(String usuario, String contrasena) async{
    bool _validate = false;
    Login _loginObject = Login(usuario: usuario, contrasena: contrasena);
    log("--- $_loginObject");
    log("xxxxxxxxxxxx  2");
    Session session = await _repository.validateLoginAPI(_loginObject);
    if(session.token != null){
      DateTime timeSession = DateTime.now();
      // await _repository.saveLocalSessionStorage(
      //   session, timeSession.toString(),usuario
      // );
      _access = true;
    }else{
      _message = "Las credenciales son incorrectas";
      _access = false;
      _validate = true;
    }

    // loadingController.skin.add(true);
    // loginController.skin.add(session);

    return _access!;
  }

}