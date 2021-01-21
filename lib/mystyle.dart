import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double maxScreenSize = 1080;
double mediumScreenSize = 850;
double minScreenSize = 500;
double widthToHide = 800;
double sizeMiPantalla = 763.2000122070312;
Color _color = Color(0xFF3A56BC);
Color _colorAzulClaro = Color(0xFF5E81FE);
Color _colorAzulMedio = Color(0xFF6E87DC);
Color _colorAppBar = Color(0xFFC2DAFF);
Color _colorVerde = Color(0xFFC7F3DB);
Color _colorVerdeOscuro = Color(0xFF83C6A2);
Color _colorGris = Color(0xFFbebebe);
Color _colorGrisOscuro = Color(0xFFa0a0a0);
Color _colorHome = Color(0xFFEEF9FF);
Color _colorFooter = Color(0xff90A8FF);
double roundedL = 7;
double roundedM = 12;
double roundedB = 17;

String codigoImagen = "https://drive.google.com/uc?id=";
String imageHome = codigoImagen + "1pJFsMGZEkuBFky0WwVlhKGafgDIwFF-b";

class MyColors{

  Color colorOscuro(){
    return _color;
  }

  Color colorFooter(){
    return _colorFooter;
  }

  Color colorClaro(){
    return _colorHome;
  }

  Color colorAzulClaro(){
    return _colorAzulClaro;
  }

  Color colorAzulMedio(){
    return _colorAzulMedio;
  }

  Color colorVerde(){
    return _colorVerde;
  }

  Color colorVerdeOscuro(){
    return _colorVerdeOscuro;
  }

  Color colorGris(){
    return _colorGris;
  }

  Color colorGrisOscuro(){
    return _colorGrisOscuro;
  }

  Color colorAppBar(){
    return _colorAppBar;
  }
}

class MyRText extends StatelessWidget {
  final String text;
  final double minSize;
  final double maxSize;
  final Color color;
  final int bold;
  final String tipo;
  final TextAlign textAlign;
  final TextDirection textDirection;

  const MyRText({
    Key key,
    this.text,
    this.minSize,
    this.maxSize,
    this.color,
    this.bold,
    this.tipo,
    this.textAlign,
    this.textDirection
  }):super(key:key);
  
  FontWeight _bold(){
    if(bold==6){
      return FontWeight.w600;
    }else if(bold==7){
      return FontWeight.w700;
    }else if(bold == 5){
      return FontWeight.w500;
    }else{
      return FontWeight.w400;
    }
  }

  List<int> _sizes(){
    if(tipo == "buttonContent"){
      return [14, 16];
    }else if(tipo == "title"){
      return [40, 46];
    }else if(tipo == "body"){
      return [16, 18];
    }else if(tipo == "bodyB"){
      return [18, 20];
    }else if(tipo == "bodyL"){
      return [14, 16];
    }else if(tipo == "bodyLL"){
      return [12, 14];
    }else if(tipo == "bodyLLL"){
      return [10, 12];
    }else if(tipo == "subtitle"){
      return [22, 26];
    }else if(tipo == "subtitleL"){
      return [18, 22];
    }else{
      return [14, 16];
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    double width = sW > maxScreenSize ? sW : maxScreenSize;
    double fontSize = lerpDouble((_sizes()[0] - (_sizes()[1] - _sizes()[0])), _sizes()[1], sW/width);

    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: _bold(),
      ),
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}

class MyROutlineButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final void Function() onPressed;

  const MyROutlineButton({Key key, this.child, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    double width = sW > maxScreenSize ? sW : maxScreenSize + 1/sW;

    double horizontalPadding = lerpDouble(6, 15, sW/width);
    double verticalPadding = lerpDouble(4, 8.7, sW/width);

    return FlatButton(
      shape: ContinuousRectangleBorder(
        side: BorderSide(color: color),
        borderRadius: BorderRadius.circular(roundedL+3)
      ),
      color: Colors.white.withOpacity(0.3),
      hoverColor: Colors.white.withOpacity(0.8),
      splashColor: MyColors().colorClaro(),
      highlightColor: MyColors().colorClaro(),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding
        ),
        child: child,
      ),
    );
  }
}

class MyRButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final void Function() onPressed;

  const MyRButton({Key key, this.child, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    double width = sW > maxScreenSize ? sW : maxScreenSize + 1/sW;

    print("Width actual: " + sW.toString());
    print("Height actual: " + screenS.height.toString());

    double horizontalPadding = lerpDouble(8, 15, sW/width);
    double verticalPadding = lerpDouble(4, 10, sW/width);

    return Container(
      //height: 24+verticalPadding*2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF456BF1),
            Color(0xFF5E81FE)
          ]
        ),
        borderRadius: BorderRadius.circular(roundedL)
      ),
      child: FlatButton(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(roundedL)
        ),
        color: Colors.transparent,
        hoverColor: Colors.white.withOpacity(0.1),
        splashColor: Colors.lightBlue[200],
        highlightColor: Colors.white.withOpacity(0.2),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding
          ),
          child: child,
        ),
      ),
    );
  }
}

class MyRTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String initialValue;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;

  const MyRTextFormField({Key key, this.controller, this.initialValue, this.hintText, this.keyboardType, this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    double width = sW > maxScreenSize ? sW : maxScreenSize + 1/sW;

    //double horizontalPadding = lerpDouble(8, 17, sW/width);
    double verticalPadding = lerpDouble(4, 15, sW/width);
    double fontSize = lerpDouble(12, 16, sW/width);

    return TextFormField(
      cursorHeight: fontSize*1.5,
      cursorColor: MyColors().colorOscuro(),
      obscureText: obscureText,
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: MyColors().colorOscuro(),
        fontWeight: FontWeight.w400
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().colorGris(), width: 1),
          borderRadius: BorderRadius.zero
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors().colorGris(), width: 1),
          borderRadius: BorderRadius.zero
        ),
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: verticalPadding
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: fontSize,
          color: MyColors().colorGris(),
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}

class HideIf extends StatelessWidget {
  final double minWidth;
  final Widget child;

  const HideIf({Key key, this.minWidth, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    if(sW > minWidth){
      return child;
    }else{
      return Container();
    }
  }
}

