class Login {
  String? correo;
  String? contrasena;
  Login({this.correo,this.contrasena});

  factory Login.fromJson(Map<String,dynamic> parsedJson){
    return Login(
      correo: parsedJson['correo'],
      contrasena: parsedJson['contrasena']
    );
  }

  Map<String, dynamic> toJson() => {
    'correo' : correo,
    'contrasena' : contrasena
  };
}