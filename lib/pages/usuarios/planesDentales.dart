import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../myWidgets.dart';
import '../../mystyle.dart';
import '../datos.dart';


double _separador = 20;

class PlanesDentalesHome extends StatefulWidget {
  @override
  _PlanesDentalesHomeState createState() => _PlanesDentalesHomeState();
}

class _PlanesDentalesHomeState extends State<PlanesDentalesHome> {
  @override
  Widget build(BuildContext context) {

    var sW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(
          tipo: rolGlobal,
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _Razones(sW),
              _MejorSonrisa(sW),
              _Planes(sW),
              Footer()
            ],
          )
        ),
      ),
    );
  }
}

class _Razones extends StatelessWidget {

  double sW;
  double _alturaImagen = 100;

  _Razones(this.sW);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 900 - _alturaImagen*4,
          height: sizeMiPantalla - sizeAppBar,
          padding: EdgeInsets.only(bottom: 60),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/flechas.png"),
              fit: BoxFit.fitWidth
            )
          ),
        ),
        Container(
          height: sizeMiPantalla - sizeAppBar,
          width: 900,
          padding: EdgeInsets.only(top: _alturaImagen/1.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _elemento(
                image: "assets/iconos/dinero.png",
                encabezado: "Paga menos",
                descripcion: "Con nuestros planes asegúrese de pagar menos por cubrir sus cuidados dentales."
              ),
              Transform.translate(
                offset: Offset(0, -_alturaImagen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _elemento(
                      image: "assets/iconos/seguro.png",
                      encabezado: "Protégete",
                      descripcion: "Descanse tranquilo sabiendo que frente a cualquier problema dental estamos nosotros para ayudarlo."
                    ),
                    _elemento(
                      image: "assets/iconos/sonrisa.png",
                      encabezado: "Sonríe más",
                      descripcion: "Sienta la plena confianza de poder mostrar una sonrisa envidiable, y a un bajo coste."
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _elemento({String image, String encabezado, String descripcion}){
    return Container(
      width: _alturaImagen * 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: _alturaImagen,
            width: _alturaImagen,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain
              )
            ),
          ),
          SizedBox(height: _separador),
          MyRText(
            textAlign: TextAlign.center,
            text: encabezado,
            tipo: "subtitle",
            color: MyColors().colorOscuro(),
            bold: 7
          ),
          SizedBox(height: _separador/2),
          MyRText(
            textAlign: TextAlign.center,
            text: descripcion,
            tipo: "body",
            color: MyColors().colorVerdeOscuro(),
            bold: 5
          ),
        ],
      ),
    );
  }
}

Widget _MejorSonrisa(double sW){
  return Container(
    color: MyColors().colorClaro(),
    height: sizeMiPantalla - sizeAppBar,
    width: double.infinity,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 0),
          height: sizeMiPantalla - sizeAppBar - 120,
          width: sW/1.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/mejorsonrisa.png"),
              fit: BoxFit.contain,
              alignment: Alignment.centerRight
            )
          ),
        ),
        Container(
          height: sizeMiPantalla - sizeAppBar,
          width: sW/1.3,
          alignment: Alignment.centerLeft,
          child: Container(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(color: MyColors().colorOscuro(), fontWeight: FontWeight.w500, fontSize: 28),
                    children: [
                      TextSpan(text: "Nuestros planes le ofrecen "),
                      TextSpan(text: "completa protección ", style: GoogleFonts.poppins(color: MyColors().colorVerdeOscuro(), fontWeight: FontWeight.w500, fontSize: 28)),
                      TextSpan(text: "frente a los problemas dentales que pudieran afectarle a usted o a su familia, desde una limpieza rutinaria hasta cirugías bucales. No espere a estar en problemas para buscarnos."),
                    ]
                  )
                ),
                SizedBox(height: _separador),
                MyRText(
                  text: "Protégete ya.",
                  tipo: "subtitle",
                  color: MyColors().colorVerdeOscuro(),
                  bold: 5
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

int _indexApuntado = 2;

class _Planes extends StatefulWidget {

  double sW;

  _Planes(this.sW);

  @override
  __PlanesState createState() => __PlanesState();
}

class __PlanesState extends State<_Planes> {

  void tarjetaApuntada(int valor){
    setState(() {
      _indexApuntado = valor;
    });
  }

  List<String> beneficiosCero = [
    "Aparición de caries",
    "Mal aliento",
    "Gingivitis",
    "Infecciones",
    "Caída de dientes",
  ];

  List<String> beneficiosInicial = [
    "Radiografías",
    "Curaciones",
    "Exodoncia",
    "Endodoncia",
  ];

  List<String> beneficiosExperto = [
    "Cirugías Bucales",
    "Limpieza Dental",
    "Radiografías",
    "Curaciones",
    "Exodoncia",
    "Endodoncia",
  ];

  double marginPlan = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeMiPantalla - sizeAppBar,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyRText(
            text: "Nuestros Planes",
            tipo: "title",
            color: MyColors().colorOscuro(),
            bold: 7
          ),
          //SizedBox(height: _separador/3),
          MyRText(
            text: "Hicimos nuestros costos accesibles, para que sonrías al pagarlos.",
            tipo: "bodyB",
            color: MyColors().colorVerdeOscuro(),
            bold: 5
          ),
          SizedBox(height: _separador),
          Container(
            width: widget.sW / 1.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _TarjetaDental(datosPlanes[0], beneficiosCero, MyColors().colorPlanDentalCero(), "assets/planDental/diente-bad.png", 0, tarjetaApuntada),
                      _TarjetaDental(datosPlanes[1], beneficiosInicial, MyColors().colorPlanDentalInicial(), "assets/planDental/diente-low.png", 1, tarjetaApuntada),
                      _TarjetaDental(datosPlanes[2], beneficiosExperto, MyColors().colorPlanDentalExperto(), "assets/planDental/diente-high.png", 2, tarjetaApuntada),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyRText(
                      text: "* El pago es mensual y se actualizará automáticamente, a menos que desee",
                      tipo: "bodyL",
                      color: MyColors().colorGris(),
                      bold: 5
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8
                        )
                      ),
                      onPressed: () {},
                      child: MyRText(
                        text: "cancelar su afiliación",
                        tipo: "bodyL",
                        color: MyColors().colorOscuro(),
                        bold: 5
                      )
                    )
                  ],
                ),
                MyRText(
                  text: "* Precio válido solo para las primeras 30 compras.",
                  tipo: "bodyL",
                  color: MyColors().colorGris(),
                  bold: 5
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaDental extends StatefulWidget {

  Map datos;
  List<String> beneficios;
  List<Color> colores;
  String image;
  int indice;
  Function tarjetaApuntada;

  _TarjetaDental(this.datos, this.beneficios, this.colores, this.image, this.indice, this.tarjetaApuntada);

  @override
  __TarjetaDentalState createState() => __TarjetaDentalState();
}

class __TarjetaDentalState extends State<_TarjetaDental> {

  double _anchoPlan = 300;
  double _alturaPlan =  400;  

  double margin = 30;
  Duration _duracion = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyRText(
              text: "S/. ${widget.datos["costo"]}0",
              tipo: "precio",
              color: Color(0xFF4568E7),
              bold: 7
            ),
            SizedBox(height: separador/3),
            Container(
              height: _alturaPlan,
              width: _anchoPlan,
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: _duracion,
                padding: EdgeInsets.only(bottom: _indexApuntado == widget.indice ? 20 : 15),
                child: MyRButton(
                  onPressed: () {},
                  child: MyRText(
                    text: "Afiliarme",
                    tipo: "bodyLL",
                    color: Colors.white,
                    bold: 5
                  ),
                ),
              )
            )
          ]
        ),
        GestureDetector(
          onTap: (){
            if(datosPersonales["dni"] == null){
              print("No hay cuenta");
            }else{
              print("Hay cuenta");
            }
          },
          child: MouseRegion(
            onEnter: (_) {widget.tarjetaApuntada(widget.indice);},
            onExit: (_) {widget.tarjetaApuntada(10);},
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              curve: Curves.easeInOutSine,
              duration: _duracion,
              margin: EdgeInsets.only(top: _indexApuntado == widget.indice ? 0 : margin*2),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [

                  //Container que crece cuando el plan se eleva, manteniendo clicable el campo por debajo del plan
                  AnimatedContainer(
                    duration: _duracion,
                    height: _indexApuntado == widget.indice ? _alturaPlan + margin*2 + 10 : _alturaPlan,
                    width: _anchoPlan,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(),
                  ),

                  //Fondo de color
                  Container(
                    height: _alturaPlan,
                    width: _anchoPlan,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(roundedB*2),
                      gradient: LinearGradient(
                        colors: widget.colores,
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15),
                    alignment: Alignment.topCenter,
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(fontSize: 36, color: Colors.white, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(text: "Plan "),
                          TextSpan(text: widget.datos["plan"], style: GoogleFonts.poppins(fontSize: 36, color: Color(0xFF274879), fontWeight: FontWeight.w600)),
                        ]
                      ),
                    ),
                  ),

                  //Imagen del diente
                  Container(
                    height: _alturaPlan,
                    width: _anchoPlan,
                    child: Column(
                      children: [
                        AnimatedContainer(
                          curve: Curves.easeInOutSine,
                          duration: _duracion,
                          height: _alturaPlan/1.75,
                          width: _anchoPlan/1.6,
                          margin: EdgeInsets.only(
                            top: _indexApuntado == widget.indice ? 0 : margin,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.image),
                              fit: BoxFit.fitWidth,
                            )
                          ),
                        ),
                        Expanded(child: Container(),)
                      ],
                    ),
                  ),

                  //Titulo, manos y textos
                  Container(
                    height: _alturaPlan,
                    width: _anchoPlan,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF9AC1FC),
                        borderRadius: BorderRadius.circular(roundedB*2)
                      ),
                      height: _alturaPlan * 11/18,
                      width: _anchoPlan,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Transform.translate(
                            offset: Offset(0, -10),
                            child: Row(
                              children: [
                                Expanded(child: Container(),),
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: Image.asset(
                                    widget.indice == 0
                                    ? "assets/planDental/dientes-manos-bad.png"
                                    : "assets/planDental/dientes-manos.png"
                                  )
                                ),
                                SizedBox(width: _anchoPlan/8),
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: Image.asset(
                                    widget.indice == 0
                                    ? "assets/planDental/dientes-manos-bad.png"
                                    : "assets/planDental/dientes-manos.png"
                                  )
                                ),
                                Expanded(child: Container(),),
                              ]
                            ),
                          ),
                          Expanded(child: Container(),),
                          for (var i = 0; i < widget.beneficios.length; i++)
                            Padding(
                              padding: EdgeInsets.only(
                                right: separador/2,
                              ),
                              child: MyRText(
                                text: widget.beneficios[i],
                                tipo: "bodyB",
                                color: Colors.white,
                                bold: 6
                              ),
                            ),
                          SizedBox(height: separador/4)
                        ]
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}