import 'package:flutter/material.dart';

import '../../myWidgets.dart';
import '../datos.dart';
import '../../mystyle.dart';

class Nosotros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double sW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(
          tipo: rolGlobal,
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: sizeMiPantalla - sizeAppBar,
              width: double.infinity,
              alignment: Alignment.center,
              child: _Header(sW)
            ),
            Container(
              //height: sizeMiPantalla - sizeAppBar,
              width: double.infinity,
              child: _Filosofia(sW)
            ),
            Container(
              height: (sizeMiPantalla - sizeAppBar) * 1.5,
              width: sW / 1.3,
              child: _Pilares(sW)
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {

  final double sW;

  const _Header(this.sW);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: sW/1.7,//722,
            height: sizeMiPantalla/1.7,
            decoration: BoxDecoration(
              //color: Colors.red,
              image: DecorationImage(
                image: AssetImage("assets/nosotros-dibujo.png"),
                fit: BoxFit.contain
              )
            ),
          ),
          Container(
            child: MyRText(
              text: "Nos apasiona tu sonrisa.",
              color: MyColors().colorOscuro(),
              tipo: "title",
              bold: 7,
            ),
          ),
          Container(
            child: MyRText(
              textAlign: TextAlign.center,
              text: "Y por eso queremos brindarte los mejores servicios junto a la mejor experiencia.",
              color: MyColors().colorVerdeOscuro(),
              tipo: "bodyB",
              bold: 5,
            ),
          ),
        ]
      )
    );
  }
}

class _Filosofia extends StatelessWidget {

  final double sW;
  const _Filosofia(this.sW);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

List<String> mision = [
  "Misión",
  "Brindar un servicio excelente y de calidad inmejorable para pacientes decididos a mejorar su salud dental, mediante intervenciones necesarias o estéticas con equipo especializado y de última generación, capaz de obtener resultados inigualables y eficaces.",
  "assets/iconos/mision.png",
];

List<String> vision = [
  "Visión",
  "Pretendemos convertirnos en un referente odontológico en el Perú, mediante prácticas innovadoras, trato preferente con nuestros pacientes, y servicio de primera calidad. Ocupándonos de poner todo nuestro esfuerzo por mejorar la salud y estética dental de nuestros pacientes.",
  "assets/iconos/vision.png",
];

List<String> valores = [
  "Valores",
  "Honestidad, perseverancia, lealtad y respeto son los valores que nos identifican. No descansamos hasta tener un cliente satisfecho y sonriente. Nuestra mayor satisfacción es la felicidad en nuestros pacientes. Además contamos con un equipo totalmente certificado, confiable y dedicado para nuestro principal valor: Usted. ",
  "assets/iconos/valores.png",
];

class _Pilares extends StatelessWidget {

  final double sW;
  const _Pilares(this.sW);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyRText(
            text: "Nuestra misión, visión y valores.",
            tipo: "bodyB",
            color: MyColors().colorVerdeOscuro(),
            bold: 5
          ),
          MyRText(
            text: "Pilares Fundamentales",
            tipo: "title",
            color: MyColors().colorOscuro(),
            bold: 7
          ),
          SizedBox(height: 15),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _MVV(sW, mision),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _MVV(sW, vision),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _MVV(sW, valores),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _MVV(double sW, List<String> datos){

    double marginImage = sW/12;

    Color _logicaColor(){
      if(datos[0] == "Misión"){
        return Color(0xFFDAE9FF);
      }else if(datos[0] == "Visión"){
        return Color(0xFFE9F2FF);
      }else{
        return MyColors().colorClaro();
      }
    }

    return Container(
      width: sW / 1.7,
      decoration: BoxDecoration(
        color: _logicaColor(),
        borderRadius: BorderRadius.circular(roundedB),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: sW / 1.7,
            height: 150,
            alignment: datos[0] == "Visión" ? Alignment.centerLeft : Alignment.centerRight,
            child: Transform.translate(
              offset: Offset(
                datos[0] == "Visión" ? -marginImage : marginImage,
                0
              ),
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(datos[2])
              ),
            ),
          ),
          Column(
            crossAxisAlignment: datos[0] == "Visión" ? CrossAxisAlignment.end : CrossAxisAlignment.stretch,
            children: [
              MyRText(
                text: datos[0],
                tipo: "subtitle",
                color: MyColors().colorOscuro(),
                bold: 7
              ),
              SizedBox(height: 5),
              MyRText(
                textAlign: datos[0] == "Visión" ? TextAlign.end : TextAlign.start,
                text: datos[1],
                tipo: "bodyB",
                color: MyColors().colorAzulMedio(),
                bold: 5
              ),
            ],
          ),
        ],
      ),
    );
  }
}