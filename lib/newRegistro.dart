late String nombre, apellidoPaterno, apellidoMaterno, rut, tipoUsuario, email, password, telefono, patente;

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

void llenarRegistro(String rut0, String tipoUsuario0, String nombre0, String apellidoPaterno0, String apellidoMaterno0, String email0, String telefono0) {
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

List<String> getRegistro() {
  return [rut, tipoUsuario, nombre, apellidoPaterno, apellidoMaterno, email, password, telefono];
}

void llenarAuto(String patente0) {
  patente = patente0;
}

List<String> getAuto() {
  return [patente];
}