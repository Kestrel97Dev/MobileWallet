class Usuario {
  String? id;
  String? nombres;
  String? apellidos;
  String? correo;
  String? contrasenaAnterior;
  String? contrasena;
  bool? estado;

  Usuario(
      {this.id,
      this.nombres,
      this.apellidos,
      this.correo,
      this.contrasenaAnterior,
      this.contrasena,
      this.estado});

  factory Usuario.fromJson(Map<String, dynamic> parsedJson) {
    return Usuario(
        id: parsedJson['id'],
        nombres: parsedJson['nombres'],
        apellidos: parsedJson['apellidos'],
        correo: parsedJson['correo'],
        contrasenaAnterior: parsedJson['contrasenaAnterior'],
        contrasena: parsedJson['contrasena'],
        estado: parsedJson['estado']);
  }

  Map<String, dynamic> toJson() => {
        'nombres': nombres,
        'apellidos': apellidos,
        'contrasenaAnterior': contrasenaAnterior,
        'contrasena': contrasena
      };
}
