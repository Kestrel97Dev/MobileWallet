class Login {
  String? usuario;
  String? contrasena;
  Login({this.usuario,this.contrasena});

  factory Login.fromJson(Map<String,dynamic> parsedJson){
    return Login(
      usuario: parsedJson['usuario'],
      contrasena: parsedJson['contrasena']
    );
  }

  Map<String, dynamic> toJson() => {
    'usuario' : usuario,
    'contrasena' : contrasena
  };
}