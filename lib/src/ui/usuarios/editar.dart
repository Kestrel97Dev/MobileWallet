import 'package:billeteraflutter/src/bloc/usuario_bloc.dart';
import 'package:billeteraflutter/src/models/usuario_model.dart';
import 'package:billeteraflutter/src/ui/login.dart';
import 'package:billeteraflutter/src/ui/principal.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class EditarUsuarioScreen extends StatefulWidget {
  final Usuario usuario;
  const EditarUsuarioScreen({Key? key, required this.usuario})
      : super(key: key);

  @override
  State<EditarUsuarioScreen> createState() => _EditarUsuarioScreemState();
}

class _EditarUsuarioScreemState extends State<EditarUsuarioScreen> {
  Usuario usuario = Usuario();
  final UsuariosBloc usuarioBloc = UsuariosBloc();
  bool formEdited = false;
  bool _autovalidate = false;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  void _editarUsuario() {
    final FormState? form = _formKey1.currentState;

    if (!form!.validate()) {
      _autovalidate = true;
    } else {
      form.save();
      log("lo que va a enviar a la petición ${usuario.nombres}");
      usuarioBloc.editarUsuario(usuario).then(
        (bool editado) {
          if (editado) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Exíto"),
                content: const Text("Se ha editado la información"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrincipalScreen()));
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
                    "No se ha editado la información, intente nuevamente"),
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

  void _eliminarUsuario(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Por favor confirme'),
            content: const Text('Esta seguro de desactivar su cuenta?'),
            actions: [
              TextButton(
                onPressed: () {
                  usuarioBloc.eliminarUsuario().then(
                    (bool eliminado) {
                      if (eliminado) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Exíto"),
                            content: const Text("Se ha desactivado su cuenta"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {});

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) {
                                    return const LoginScreen();
                                  }), (Route<dynamic> route) => false);
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
                                "No se ha desactivado su cuenta, intente nuevamente"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PrincipalScreen()),
                                  );
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
                child: const Text('Si'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar información"),
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
                      initialValue: '${widget.usuario.nombres}',
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
                      initialValue: '${widget.usuario.apellidos}',
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
                      keyboardType: TextInputType.text,
                      onSaved: (String? value) {
                        usuario.contrasenaAnterior = value!;
                      },
                      decoration: const InputDecoration(
                          labelText: "Contraseña anterior"),
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
                      decoration:
                          const InputDecoration(labelText: "Contraseña nueva"),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.2,
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      onPressed: _editarUsuario,
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
                          "Actualizar información",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    width: size.width * 0.2,
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _eliminarUsuario(context);
                      },
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
                              Color.fromARGB(255, 255, 71, 34),
                              Color.fromARGB(255, 255, 80, 41)
                            ])),
                        padding: const EdgeInsets.all(0),
                        child: const Text(
                          "Desactivar cuenta?",
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
