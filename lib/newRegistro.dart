late String nombre, apellidoPaterno, apellidoMaterno, rut, tipoUsuario, email, patente, marca, modelo, year, password;

void vaciarRegistro() {
  nombre = "";
  apellidoPaterno = "";
  apellidoMaterno = "";
  rut = "";
  tipoUsuario = "";
  email = "";
  patente = "";
  marca = "";
  modelo = "";
  year = "";
  password = "";
}

void llenarRegistro(String nombre0, String apellidoPaterno0, String apellidoMaterno0, String rut0, String tipoUsuario0, String email0, String patente0, String marca0, String modelo0, String year0) {
  nombre = nombre0;
  apellidoPaterno = apellidoPaterno0;
  apellidoMaterno = apellidoMaterno0;
  rut = rut0;
  tipoUsuario = tipoUsuario0;
  email = email0;
  patente = patente0;
  marca = marca0;
  modelo = modelo0;
  year = year0;
}

void llenarPassword(String password0) {
  password = password0;
}

List<String> getRegistro(){
  return [nombre, apellidoPaterno, apellidoMaterno, rut, tipoUsuario, email, patente, marca, modelo, year, password];
}
