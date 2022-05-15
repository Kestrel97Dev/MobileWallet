import 'package:billeteraflutter/src/ui/registro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:billeteraflutter/src/bloc/login_bloc.dart';
import 'dart:developer';

import 'package:billeteraflutter/src/ui/principal.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreemState();
}

class UserData {
  String correo = '';
  String contrasena = '';
}

class _LoginScreemState extends State<LoginScreen> {
  final LoginBloc loginBloc = LoginBloc();
  final storage = const FlutterSecureStorage();
  UserData user = UserData();
  bool formEdited = false;
  bool _autovalidate = false;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  void _handleSubmitted() {
    final FormState? form = _formKey1.currentState;

    if (!form!.validate()) {
      _autovalidate = true;
    } else {
      form.save();
      loginBloc
          .validateLogin(user.correo.replaceAll(" ", ""), user.contrasena)
          .then((bool access) async {
        if (access) {
          log("se redirige a la pantalla principal ya logueado");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PrincipalScreen()));
        } else {
          log("se queda en el login y muestra error de logueo");
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Error"),
              content: const Text("Correo o contraseña incorrectos"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Ok"),
                ),
              ],
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Login Billetera",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                width: size.width * 0.20,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    user.correo = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: "Correo",
                  ),
                  validator: (value) {
                    formEdited = true;
                    if (value == null || value.isEmpty) {
                      return "El correo no puede ser vacio";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: size.width * 0.20,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (String? value) {
                    user.contrasena = value!;
                  },
                  decoration: const InputDecoration(labelText: "Contraseña"),
                  obscureText: true,
                  validator: (value) {
                    formEdited = true;
                    if (value == null || value.isEmpty) {
                      return "La contraseña no puede ser vacia";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: (loginBloc.validate) ? _handleSubmitted : () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: const Text(
                      "Ingresar",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              /*Boton registro*/
              Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AgregarUsuarioScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 34, 181, 255),
                          Color.fromARGB(255, 34, 181, 255),
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: const Text(
                      "Registro",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
