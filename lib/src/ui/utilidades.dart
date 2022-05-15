import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:billeteraflutter/src/ui/principal.dart';

class Utilidades {
  menuLateral(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Proyecto - Billetera',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Usuario'),
            onTap: () {
              if (context.widget.toString() == "UsuariosScreen") {
                Navigator.of(context).pop();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrincipalScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
