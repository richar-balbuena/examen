import 'package:examen/calculadora/calcu_controlador/calcu_controlador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sub_result.dart';
import 'line_sepador.dart';
import 'main_result.dart';

class MathResults extends StatelessWidget {
  final calculatorCtrl = Get.find<CalcuControlador>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SubResult(text: '${calculatorCtrl.firstNumber}'),
          SubResult(text: '${calculatorCtrl.operation}'),
          SubResult(text: '${calculatorCtrl.secondNumber}'),
          LineSepador(),
          MainResultText(text: '${calculatorCtrl.mathResult}'),
        ],
      ),
    );
  }
}
