import 'package:flutter/material.dart';
import 'package:poo_web/pages/pacientes/fichaPersonal.dart';

import '../../mystyle.dart';
import '../datos.dart';
import '../maquetaPerfil.dart';
import 'citas.dart';

class PlanDental extends StatefulWidget {
  @override
  _PlanDentalState createState() => _PlanDentalState();
}

class _PlanDentalState extends State<PlanDental> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _header(),
        _tiempoAfiliado()
      ],
    );
  }
}

Widget _header(){
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              _planDental("${planExperto["plan"]}", "${planExperto["precio"]}"),
              SizedBox(height: separador/4),
              _planDental("${planInicial["plan"]}", "${planInicial["precio"]}"),
              SizedBox(height: separador/4),
              _planDental("${planCero["plan"]}", "${planCero["precio"]}"),
              SizedBox(height: separador*1.5),
              _estadoPlan()
            ],
          )
        )
      ],
    )
  );
}

Widget _planDental(String plan, String precio){

  double alturaPlan = 40;
  double anchoPlan = 350;

  Widget planAfiliado(){
    if(plan == datosPlan["plan"]){
      return MyRText(
        text: "Plan Actual",
        tipo: "bodyLLL",
        color: Colors.white,
        bold: 7
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
        onPressed: () {},
      );
    }
  }

  return Container(
    width: 300,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              color: Colors.transparent,
              width: anchoPlan,
              height: alturaPlan,
            ),
            Container(
              decoration: BoxDecoration(
                color: MyColors().colorAzulClaro(),
                borderRadius: BorderRadius.circular(roundedB)
              ),
              width: anchoPlan,
              height: alturaPlan,
              alignment: Alignment.bottomRight,
              child: Container(
                width: anchoPlan * 0.55,
                height: alturaPlan,
                decoration: BoxDecoration(
                  color: Color(0xFF9AC1FC),
                  borderRadius: BorderRadius.circular(roundedB)
                ),
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 4
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyRText(
                text: "Plan",
                tipo: "subtitleL",
                color: MyColors().colorOscuro(),
                bold: 7
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyRText(
                      text: plan,
                      tipo: "subtitleL",
                      color: Colors.white,
                      bold: 7
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: MyRText(
                        text: "S/. $precio",
                        tipo: "bodyLL",
                        color: MyColors().colorAzulClaro(),
                        bold: 7
                      ),
                    ),
                  ),
                  Expanded(child: Container(alignment: Alignment.centerRight, child: planAfiliado()))
                ],
              ),
            ],
          ),
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

Widget _tiempoAfiliado(){

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
                children: [
                  Container(
                    height: alturaBarra,
                    width: 570,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(roundedB)
                    ),
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: 1/7,
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
                          color: MyColors().colorAzulMedioBajo(),
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