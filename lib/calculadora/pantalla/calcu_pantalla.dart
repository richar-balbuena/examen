/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:examen/calculadora/calcu_controlador/calcu_controlador.dart';
import 'package:examen/calculadora/widgets/math_result.dart';
import 'package:examen/calculadora/widgets/calcu_button.dart';

class CalcuPantalla extends StatelessWidget {
  final calculatorCtrl = Get.put(CalcuControlador());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.delete<CalcuControlador>();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Calculadora',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [//fonde la calculadora
                const Color.fromARGB(186, 123, 121, 121),
                const Color.fromARGB(186, 123, 121, 121),
              ],
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(child: Container()),
              MathResults(),

              // Primera fila: AC, +/-, %, /
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: 'C',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.resetAll(),
                    ),
                  ),


                  
                  Expanded(
                    child: CalcuButton(
                      text: '+/-',
                      bgColor: const Color(0xFF505050),
                      onPressed: () => calculatorCtrl.changeNegativePositive(),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '%',
                      bgColor: const Color(0xFF505050),
                      onPressed: () => calculatorCtrl.calculatePercentage(),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '/',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.selectOperation('/'),
                    ),
                  ),
                ],
              ),

              // Segunda fila: 7, 8, 9, x
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: '7',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('7'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '8',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('8'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '9',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('9'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: 'x',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.selectOperation('x'),
                    ),
                  ),
                ],
              ),

              // Tercera fila: 4, 5, 6, -
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: '4',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('4'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '5',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('5'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '6',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('6'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '-',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.selectOperation('-'),
                    ),
                  ),
                ],
              ),

              // Cuarta fila: 1, 2, 3, +
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: '1',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('1'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '2',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('2'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '3',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('3'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '+',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.selectOperation('+'),
                    ),
                  ),
                ],
              ),

              // Quinta fila: ^, 0, ., =
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: '^',
                      bgColor: const Color(0xFF505050),
                      onPressed: () => calculatorCtrl.selectOperation('^'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '0',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('0'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '.',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addDecimalPoint(),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '=',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.calculateResult(),
                    ),
                  ),
                ],
              ),

              // Sexta fila: DEL (ancho completo)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: 'DEL',
                      bgColor: const Color(0xFFFF3B30),
                      onPressed: () => calculatorCtrl.deleteLastEntry(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:examen/calculadora/calcu_controlador/calcu_controlador.dart';
import 'package:examen/calculadora/widgets/math_result.dart';
import 'package:examen/calculadora/widgets/calcu_button.dart';

class CalcuPantalla extends StatelessWidget {
  final calculatorCtrl = Get.put(CalcuControlador());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.delete<CalcuControlador>();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Calculadora',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(186, 123, 121, 121),
                const Color.fromARGB(186, 123, 121, 121),
              ],
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(child: Container()),
              MathResults(),

              // Primera fila: C, (, ), +/-, %, /
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: 'C',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.resetAll(),
                    ),
                  ),
                  // ✅ PARÉNTESIS DE APERTURA
                  Expanded(
                    child: CalcuButton(
                      text: '(',
                      bgColor: const Color(0xFF505050),
                      onPressed: () => calculatorCtrl.addOpenParenthesis(), // ← CORREGIDO
                    ),
                  ),
                  // ✅ PARÉNTESIS DE CIERRE
                  Expanded(
                    child: CalcuButton(
                      text: ')',
                      bgColor: const Color(0xFF505050),
                      onPressed: () => calculatorCtrl.addCloseParenthesis(), // ← CORREGIDO
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '+/-',
                      bgColor: const Color(0xFF505050),
                      onPressed: () => calculatorCtrl.changeNegativePositive(),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '%',
                      bgColor: const Color(0xFF505050),
                      onPressed: () => calculatorCtrl.calculatePercentage(),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '/',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.selectOperation('/'),
                    ),
                  ),
                ],
              ),

              // Segunda fila: 7, 8, 9, x
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: '7',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('7'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '8',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('8'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '9',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('9'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: 'x',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.selectOperation('x'),
                    ),
                  ),
                ],
              ),

              // Tercera fila: 4, 5, 6, -
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: '4',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('4'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '5',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('5'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '6',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('6'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '-',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.selectOperation('-'),
                    ),
                  ),
                ],
              ),

              // Cuarta fila: 1, 2, 3, +
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: '1',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('1'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '2',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('2'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '3',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('3'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '+',
                      bgColor: const Color(0xFFFF9500),
                      onPressed: () => calculatorCtrl.selectOperation('+'),
                    ),
                  ),
                ],
              ),

              // Quinta fila: ^, 0, ., =
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: '^',
                      bgColor: const Color(0xFF505050),
                      onPressed: () => calculatorCtrl.selectOperation('^'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '0',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addNumber('0'),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '.',
                      bgColor: const Color(0xFF333333),
                      onPressed: () => calculatorCtrl.addDecimalPoint(),
                    ),
                  ),
                  Expanded(
                    child: CalcuButton(
                      text: '=',
                      bgColor: const Color(0xFF4CAF50), // Verde para destacar
                      onPressed: () => calculatorCtrl.calculateResult(),
                    ),
                  ),
                ],
              ),

              // Sexta fila: DEL (ancho completo)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CalcuButton(
                      text: 'DEL',
                      bgColor: const Color(0xFFFF3B30),
                      onPressed: () => calculatorCtrl.deleteLastEntry(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}