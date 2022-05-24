class Ingreso {
  String? id;
  String? nombres;
  String? apellidos;
  String? correo;
  String? contrasenaAnterior;
  String? contrasena;
  bool? estado;

  Ingreso(
      {this.id,
      this.nombres,
      this.apellidos,
      this.correo,
      this.contrasenaAnterior,
      this.contrasena,
      this.estado});

  factory Ingreso.fromJson(Map<String, dynamic> parsedJson) {
    return Ingreso(
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
