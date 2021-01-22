double sangria = 10;
double separador = 40;

var datosPersonales = {
  "nombres": "John Ernesto",
  "apellidos": "Doe Quispe",
  "correo": "johndoe28@gmail.com",
  "sexo" : "hombre",
  "dni": "74056487",
  "celular": "962084579"
};

String imagePerfil = datosPersonales["sexo"] == "hombre" ? "assets/perfil-hombre.png" : "assets/perfil-mujer.png";
String imagePerfilCerca = datosPersonales["sexo"] == "hombre" ? "assets/perfil-hombre-cerca.png" : "assets/perfil-mujer-cerca.png";

var datosPlan = {
  "plan": "Inicial",
  "precio": "S/. 29.90",
};

var cita1 = {
  "especialidad": "Endodoncia",
  "fecha": "Dic, 06",
  "hora": "6:40 p.m.",
  "dentista": "Nilton Salinas",
  "costo": "----",
  "estado": "En Espera",
};

var cita2 = {
  "especialidad": "Implante Dental",
  "fecha": "Set, 22",
  "hora": "10:50 a.m.",
  "dentista": "Nilton Salinas",
  "costo": "----",
  "estado": "En Espera",
};

var cita3 = {
  "especialidad": "Limpieza Rutinaria",
  "fecha": "Ago, 30",
  "hora": "5:00 p.m.",
  "dentista": "Nilton Salinas",
  "costo": "0.00",
  "estado": "Faltó",
};

var cita4 = {
  "especialidad": "Endodoncia",
  "fecha": "Ago, 27",
  "hora": "4:30 p.m.",
  "dentista": "Nilton Salinas",
  "costo": "80.00",
  "estado": "Asistió",
};


