late String nombre, apellidoPaterno, apellidoMaterno, rut, tipoUsuario, email,password,telefono,patente,marca,modelo,anio,tipo,color;

void vaciarRegistro() {
  nombre = "";
  apellidoPaterno = "";
  apellidoMaterno = "";
  rut = "";
  tipoUsuario = "";
  email = "";
  password = "";
  telefono = "";
}

void llenarRegistro( String rut0, String tipoUsuario0, String nombre0, String apellidoPaterno0, String apellidoMaterno0,  String email0, String telefono0) {
  rut = rut0;
  tipoUsuario = tipoUsuario0;
  nombre = nombre0;
  apellidoPaterno = apellidoPaterno0;
  apellidoMaterno = apellidoMaterno0;
  email = email0;
  telefono = telefono0;
}

void llenarPassword(String password0) {
  password = password0;
}

List<String> getRegistro(){
  return [rut,tipoUsuario,nombre, apellidoPaterno, apellidoMaterno, email, password,telefono];
}


void llenarAuto(String patente0,String tipo0, String marca0, String modelo0, String anio0, String color0){
  patente = patente0;
  tipo = tipo0;
  marca = marca0;
  modelo = modelo0;
  anio = anio0;
  color = color0;
}

List<String> getAuto(){
  return [patente,tipo,marca,modelo,anio,color];
}

