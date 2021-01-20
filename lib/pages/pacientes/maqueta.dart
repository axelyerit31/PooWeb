import 'package:flutter/material.dart';

import '../../myWidgets.dart';

class Maqueta extends StatefulWidget {

  final Widget child;

  const Maqueta({Key key, this.child}) : super(key: key);

  @override
  _MaquetaState createState() => _MaquetaState();
}

class _MaquetaState extends State<Maqueta> {
  @override
  Widget build(BuildContext context) {

    double sW = MediaQuery.of(context).size.width;
    double separador = 30;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(tipo: "perfil")
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: separador, horizontal: separador),
        child: Row(
          children: [
            Expanded(flex: 2, child: Placeholder(),),
            SizedBox(width: separador),
            Expanded(flex: 6, child: Placeholder(),),
            SizedBox(width: separador),
            Expanded(flex: 3, child: Placeholder(),),
          ],
        )
      ),
    );
  }
}