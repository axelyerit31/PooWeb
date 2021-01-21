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
  "plan": "Plan Inicial",
  "precio": "S/. 29.90"
};