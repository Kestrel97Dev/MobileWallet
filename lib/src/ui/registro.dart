import 'package:billeteraflutter/src/bloc/usuario_bloc.dart';
import 'package:billeteraflutter/src/models/usuario_model.dart';
import 'package:billeteraflutter/src/ui/login.dart';
import 'package:flutter/material.dart';
import 'dart:developer';


class AgregarUsuarioScreen extends StatefulWidget {
  const AgregarUsuarioScreen({Key? key}) : super(key: key);

  @override
  State<AgregarUsuarioScreen> createState() => _AgregarUsuarioScreemState();
}

class _AgregarUsuarioScreemState extends State<AgregarUsuarioScreen> {
  final UsuariosBloc usuariosBloc = UsuariosBloc();
  Usuario usuario = Usuario();
  bool formEdited = false;
  bool _autovalidate = false;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  void _guardarUsuario() {
    final FormState? form = _formKey1.currentState;

    if (!form!.validate()) {
      _autovalidate = true;
    } else {
      form.save();
      usuariosBloc.crearUsuario(usuario).then(
        (bool creado) {
          if (creado) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Exíto"),
                content: const Text("Se ha registrado!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Error"),
                content: const Text(
                    "No se ha logrado registrar, intente nuevamente"),
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
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body: Form(
          key: _formKey1,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.2,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (String? value) {
                        usuario.nombres = value!;
                      },
                      decoration: const InputDecoration(labelText: "Nombres"),
                      validator: (value) {
                        formEdited = true;
                        if (value == null || value.isEmpty) {
                          return "Nombres no puede ser vacio";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.2,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (String? value) {
                        usuario.apellidos = value!;
                      },
                      decoration: const InputDecoration(labelText: "Apellidos"),
                      validator: (value) {
                        formEdited = true;
                        if (value == null || value.isEmpty) {
                          return "Apellidos no puede ser vacio";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.2,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? value) {
                        usuario.correo = value!;
                      },
                      decoration: const InputDecoration(labelText: "Correo"),
                      validator: (value) {
                        formEdited = true;
                        if (value == null || value.isEmpty) {
                          return "Correo no puede ser vacio";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.2,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (String? value) {
                        usuario.contrasena = value!;
                      },
                      decoration: const InputDecoration(labelText: "Contraseña"),
                      obscureText: true,
                      validator: (value) {
                        formEdited = true;
                        if (value == null || value.isEmpty) {
                          return "Contraseña no puede ser vacio";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.2,  
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      onPressed: _guardarUsuario,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ])),
                        padding: const EdgeInsets.all(0),
                        child: const Text(
                          "Registrarse",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
