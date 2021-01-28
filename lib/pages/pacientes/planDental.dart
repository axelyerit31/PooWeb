import 'package:flutter/material.dart';
import 'package:poo_web/myWidgets.dart';
import 'package:poo_web/pages/pacientes/fichaPersonal.dart';

import '../../mystyle.dart';
import '../datos.dart';
import '../maquetaPerfil.dart';
import 'citas.dart';

class PlanDental extends StatefulWidget {

  final ValueChanged<int> state;

  const PlanDental({this.state});

  @override
  _PlanDentalState createState() => _PlanDentalState();
}

class _PlanDentalState extends State<PlanDental> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _header(context, widget.state),
            _tiempoAfiliado(context)
          ],
        ),
      ),
    );
  }
}

Widget _header(BuildContext context, ValueChanged<int> state){
  return Container(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 380,
          width: 280,
          child: perfilCerca(),
        ),
        SizedBox(width: separador*2/3),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _planDental("${datosPlanes[2]["id"]}", "${datosPlanes[2]["plan"]}", "${datosPlanes[2]["costo"]}0", context, state),
              SizedBox(height: separador/4),
              _planDental("${datosPlanes[1]["id"]}", "${datosPlanes[1]["plan"]}", "${datosPlanes[1]["costo"]}0", context, state),
              SizedBox(height: separador/4),
              _planDental("${datosPlanes[0]["id"]}", "${datosPlanes[0]["plan"]}", "${datosPlanes[0]["costo"]}.00", context, state),
            ],
          )
        )
      ],
    )
  );
}

Widget _planDental(String id, String plan, String precio, BuildContext context, ValueChanged<int> state){

  double alturaPlan = 40;
  double anchoPlan = 400;

  Widget planAfiliado(){
    if(plan == datosPersonales["plan"]){
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 6
          ),
          primary: Colors.white
        ),
        child: MyRText(
          text: "Desafiliarme",
          tipo: "bodyLLL",
          color: Colors.white,
          bold: 7
        ),
        onPressed: () {
          if(id == "0"){
            rowAlert(
              "Este plan no es pagado, lo usamos para concientizar a nuestros clientes sobre todos los problemas que puede tener sin un seguro dental.", context,
              "El Plan Cero es un recordatorio"
            );
          }else{
            rowAlert("¿Está seguro que desea desafiliarse?", context,
              "Desafiliarse de Plan $plan",
              "Desafiliarme",
              (){
                Navigator.pop(context);
                editarActualizarPlan("0", datosPersonales["dni"]);
                state(2);
              },
              true,
              "Cancelar",
              (){
                Navigator.pop(context);
              }
            );
            
          }
        },
      );
    }else{
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 6
          ),
          primary: Colors.white
        ),
        child: MyRText(
          text: "Afiliarme",
          tipo: "bodyLLL",
          color: MyColors().colorOscuro(),
          bold: 7
        ),
        onPressed: () {
          rowAlert("¿Desea hacer el pago en Sonríamos Juntos, o procederá de forma virtual?", context,
            datosPersonales["sexo"] == "Masculino" ? "Bienvenido al Plan $plan" : "Bienvenida al Plan $plan",
            "Pago Virtual",
            (){
              Navigator.pop(context);
              rowAlert("Pago por método virtual.", context,
                "Pasarela de pago",
                "Pagar",
                (){
                  Navigator.pop(context);
                  editarActualizarPlan(id, datosPersonales["dni"]);
                  state(2);
                  state(2);
                }
              );
              print("Paso a pasarela");
            },
            true,
            "Pago en local",
            (){
              Navigator.pop(context);
              rowAlert("Te esperamos en Sonríamos Juntos, nos encontramos en Av. Calderon Espino, cdra. 5, frente al restaurante NhGozu. ¡Ven cuando quieras!", context,
                "Gracias por afiliarte al Plan $plan",
                "Aceptar",
                (){
                  Navigator.pop(context);
                  editarActualizarPlan(id, datosPersonales["dni"]);
                  state(2);
                  state(2);
                }
              );
            }
          );
        },
      );
    }
  }

  return Container(
    width: anchoPlan,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              color: Colors.transparent,
              width: anchoPlan,
              height: alturaPlan,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 4
              ),
              child: MyRText(
                text: "Plan",
                tipo: "subtitleL",
                color: MyColors().colorOscuro(),
                bold: 7
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: MyColors().colorAzulClaro(),
                borderRadius: BorderRadius.circular(roundedB)
              ),
              width: anchoPlan,
              height: alturaPlan,
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyRText(
                    text: plan,
                    tipo: "subtitleL",
                    color: Colors.white,
                    bold: 7
                  ),
                  Container(
                    width: anchoPlan * 0.55,
                    height: alturaPlan,
                    decoration: BoxDecoration(
                      color: Color(0xFF9AC1FC),
                      borderRadius: BorderRadius.circular(roundedB)
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyRText(
                          text: "S/. $precio",
                          tipo: "bodyLL",
                          color: MyColors().colorAzulClaro(),
                          bold: 7
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: planAfiliado()
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    )
  );
}

Widget _estadoPlan(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MyRText(text: "Estado", tipo: "subtitleL", bold: 7, color: MyColors().colorOscuro()),
      Padding(
        padding: EdgeInsets.only(left: sangria),
        child: MyRText(text: "Pagado", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
      ),
    ], 
  );
}

Widget _tiempoAfiliado(BuildContext context){

  double sW = MediaQuery.of(context).size.width;
  double alturaBarra = 40;

  return Container(
    padding: EdgeInsets.only(bottom: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyRText(
          text: "Tiempo Afiliado",
          tipo: "subtitleL",
          color: MyColors().colorOscuro(),
          bold: 7
        ),
        SizedBox(height: separador/4),
        Padding(
          padding: EdgeInsets.only(left: sangria),

          //Barra de tiempo afiliado
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: alturaBarra,
                    width: sW / 1.8 ,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(roundedB)
                    ),
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: datosPersonales["plan"] == datosPlanes[0]["plan"] ? 0 : 1/7,
                      child: Container(
                        height: alturaBarra,
                        decoration: BoxDecoration(
                          color: MyColors().colorVerde(),
                          borderRadius: BorderRadius.circular(roundedB)
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: MyRText(
                          text: "1 mes",
                          tipo: "bodyLL",
                          color: MyColors().colorAzulClaro(),
                          bold: 6
                        ),
                      ),
                    )
                  ),
                  SizedBox(width: sangria),
                  MyRText(
                    text: "1er\naño",
                    tipo: "bodyL",
                    color: MyColors().colorOscuro(),
                    bold: 6
                  )
                ],
              ),
              SizedBox(height: sangria/2),
              MyRText(
                text: "* Obtenga un descuento del 25% de por vida en su primer año de afiliado. ",
                tipo: "bodyLL",
                color: MyColors().colorAzulMedio(),
                bold: 5
              )
            ],
          ),
        )
      ],
    ),
  );
}