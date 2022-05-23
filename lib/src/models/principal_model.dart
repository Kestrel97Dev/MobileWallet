class Principal {
  int? sumatoriaIngresos;
  int? sumatoriaGastos;
  Principal({this.sumatoriaIngresos,this.sumatoriaGastos});

  factory Principal.fromJson(Map<String,dynamic> parsedJson){
    return Principal(
      sumatoriaIngresos: parsedJson['sumatoriaIngresos'],
      sumatoriaGastos: parsedJson['sumatoriaGastos']
    );
  }

  Map<String, dynamic> toJson() => {
    'sumatoriaIngresos' : sumatoriaIngresos,
    'sumatoriaGastos' : sumatoriaGastos
  };
}