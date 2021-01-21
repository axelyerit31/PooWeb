import 'package:flutter/material.dart';

import '../../mystyle.dart';

class PlanDental extends StatefulWidget {
  @override
  _PlanDentalState createState() => _PlanDentalState();
}

class _PlanDentalState extends State<PlanDental> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyRText(text: "Plan Dental", tipo: "title", bold: 7, color: MyColors().colorOscuro())
    );
  }
}