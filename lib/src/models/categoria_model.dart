class Categoria {
  String? id;
  String? nombres;
  String? apellidos;
  String? correo;
  String? contrasenaAnterior;
  String? contrasena;
  bool? estado;

  Categoria(
      {this.id,
      this.nombres,
      this.apellidos,
      this.correo,
      this.contrasenaAnterior,
      this.contrasena,
      this.estado});

  factory Categoria.fromJson(Map<String, dynamic> parsedJson) {
    return Categoria(
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
