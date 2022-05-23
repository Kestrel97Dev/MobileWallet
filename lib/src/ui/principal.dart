import 'package:billeteraflutter/src/bloc/principal_bloc.dart';
import 'package:billeteraflutter/src/bloc/usuario_bloc.dart';
import 'package:billeteraflutter/src/models/principal_model.dart';
import 'package:billeteraflutter/src/models/usuario_model.dart';
import 'package:billeteraflutter/src/ui/usuarios/editar.dart';
import 'package:billeteraflutter/src/ui/utilidades.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:developer';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({Key? key}) : super(key: key);

  @override
  State<PrincipalScreen> createState() => _PrincipalScreemState();
}

class _PrincipalScreemState extends State<PrincipalScreen> {
  final UsuariosBloc usuarioBloc = UsuariosBloc();
  final PrincipalBloc principalBloc = PrincipalBloc();
  Usuario? _usuario;
  Principal? _principal;
  bool formModalEdited = false;
  Utilidades utilidades = Utilidades();
  var f = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Billetera"),
      ),
      drawer: utilidades.menuLateral(context),
      body: FutureBuilder<Usuario?>(
        future: usuarioBloc.getUsuarioById(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _usuario = snapshot.data!;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.02),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        "Hola ${_usuario!.nombres!} ${_usuario!.apellidos!}"),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Correo: ${_usuario!.correo!}"),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarUsuarioScreen(
                              usuario: _usuario!,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Container(
                        width: size.width * 0.08,
                        alignment: Alignment.center,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ])),
                        padding: const EdgeInsets.all(0),
                        child: const Text(
                          "Editar cuenta",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Expanded(
                    child: Column(
                      children: [
                        getSumatorias(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  getSumatorias() {
    return FutureBuilder<Principal?>(
      future: principalBloc.getPrincipal(),
      builder: (context, snapshot) {
        Size size = MediaQuery.of(context).size;
        if (snapshot.connectionState == ConnectionState.done) {
          _principal = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.open_in_new_outlined,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      SizedBox(width: size.width * 0.01),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      "Ingresos",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      f.format(_principal!.sumatoriaIngresos!),
                      style: const TextStyle(color: Colors.green),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.south_east_sharp,
                        color: Colors.red,
                        size: 30.0,
                      ),
                      SizedBox(width: size.width * 0.01),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      "Gastos",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      f.format(_principal!.sumatoriaGastos!),
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
