import 'package:get/get.dart';
import 'dart:math';

class CalcuControlador extends GetxController {
  var firstNumber = '0'.obs;
  var secondNumber = '0'.obs;
  var mathResult = '0'.obs;
  var operation = '+'.obs;

  resetAll() {
    firstNumber.value = '0';
    secondNumber.value = '0';
    mathResult.value = '0';
    operation.value = '+';
  }

  changeNegativePositive() {
    if (mathResult.value == '0') return;
    if (mathResult.value.startsWith('-')) {
      mathResult.value = mathResult.value.substring(1);
    } else {
      mathResult.value = '-${mathResult.value}';
    }
  }

  addNumber(String number) {
    if (mathResult.value == '0' || mathResult.value == 'Error') {
      mathResult.value = number;
      return;
    }

    if (mathResult.value.contains('.') && number == '.') return;
    
    if (mathResult.value == '-0' && number != '.') {
      mathResult.value = '-$number';
      return;
    }
    
    mathResult.value = mathResult.value + number;
  }

  addDecimalPoint() {
    if (mathResult.value.contains('.')) return;
    mathResult.value = '${mathResult.value}.';
  }

  selectOperation(String newOperation) {
    operation.value = newOperation;
    firstNumber.value = mathResult.value;
    mathResult.value = '0';
  }

  deleteLastEntry() {
    if (mathResult.value.replaceAll('-', '').length > 1) {
      mathResult.value = mathResult.value.substring(
        0,
        mathResult.value.length - 1,
      );
    } else {
      mathResult.value = '0';
    }
  }

  calculatePercentage() {
    final number = double.tryParse(mathResult.value);
    if (number == null) return;

    final result = number / 100;
    mathResult.value = result.toString();
    _cleanResult();
  }

  _cleanResult() {
    if (mathResult.value.endsWith('.0')) {
      mathResult.value = mathResult.value.substring(
        0,
        mathResult.value.length - 2,
      );
    }
  }

  calculateResult() {
    double num1 = double.parse(firstNumber.value);
    double num2 = double.parse(mathResult.value);
    
    switch (operation.value) {
      case '+':
        mathResult.value = '${num1 + num2}';
        break;

      case '-':
        mathResult.value = '${num1 - num2}';
        break;

      case '/':
        if (num2 == 0) {
          mathResult.value = 'Error';
          return;
        }
        mathResult.value = '${num1 / num2}';
        break;

      case 'x':
        mathResult.value = '${num1 * num2}';
        break;

      case '^':
        mathResult.value = '${pow(num1, num2)}';
        break;

      default:
        return;
    }
    
    _cleanResult();
  }
}