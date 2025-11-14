/*import 'package:get/get.dart';
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
}*/

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
    if (mathResult.value == '0' || mathResult.value == 'Error') return;
    
    // Si hay paréntesis, no hacer nada por ahora
    if (mathResult.value.contains('(') || mathResult.value.contains(')')) {
      return;
    }
    
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

    // Si el último carácter es un paréntesis cerrado, no agregar número
    if (mathResult.value.endsWith(')')) {
      return;
    }

    mathResult.value = mathResult.value + number;
  }

  // Agregar paréntesis de apertura
  addOpenParenthesis() {
    if (mathResult.value == '0' || mathResult.value == 'Error') {
      mathResult.value = '(';
      return;
    }

    String lastChar = mathResult.value[mathResult.value.length - 1];
    
    // Permitir ( después de operadores o después de otro (
    if (lastChar == '+' || lastChar == '-' || lastChar == 'x' || 
        lastChar == '/' || lastChar == '^' || lastChar == '(') {
      mathResult.value = mathResult.value + '(';
    }
  }

  // Agregar paréntesis de cierre
  addCloseParenthesis() {
    if (mathResult.value == '0' || mathResult.value == 'Error') return;
    
    // Contar paréntesis
    int openCount = '('.allMatches(mathResult.value).length;
    int closeCount = ')'.allMatches(mathResult.value).length;
    
    // Solo agregar si hay paréntesis sin cerrar
    if (openCount <= closeCount) return;
    
    String lastChar = mathResult.value[mathResult.value.length - 1];
    
    // Permitir cerrar solo si el último carácter es válido
    // Números: 0-9, punto decimal, o otro paréntesis cerrado
    bool canClose = RegExp(r'[0-9.]').hasMatch(lastChar) || lastChar == ')';
    
    if (canClose) {
      mathResult.value = mathResult.value + ')';
    }
  }

  addDecimalPoint() {
    if (mathResult.value == '0' || mathResult.value == 'Error') {
      mathResult.value = '0.';
      return;
    }

    // Obtener el número actual (después del último operador)
    String expr = mathResult.value;
    RegExp numberPattern = RegExp(r'[\d.]+$');
    Match? match = numberPattern.firstMatch(expr);
    String currentNumber = match?.group(0) ?? '';
    
    // Si ya tiene punto, no agregar otro
    if (currentNumber.contains('.')) return;
    
    // Si está después de un paréntesis, no agregar
    if (expr.endsWith(')')) return;
    
    mathResult.value = mathResult.value + '.';
  }

  selectOperation(String newOperation) {
    if (mathResult.value == '0' || mathResult.value == 'Error') return;
    
    // Si ya hay una expresión compleja con paréntesis, agregar el operador
    if (mathResult.value.contains('(') || mathResult.value.contains(')')) {
      String lastChar = mathResult.value[mathResult.value.length - 1];
      
      // Solo agregar operador si el último carácter es válido
      bool canAddOp = RegExp(r'[0-9)]').hasMatch(lastChar);
      
      if (canAddOp) {
        mathResult.value = mathResult.value + newOperation;
      }
      return;
    }
    
    // Método tradicional (sin paréntesis)
    operation.value = newOperation;
    firstNumber.value = mathResult.value;
    mathResult.value = '0';
  }

  deleteLastEntry() {
    if (mathResult.value == '0' || mathResult.value == 'Error') return;
    
    if (mathResult.value.length > 1) {
      mathResult.value = mathResult.value.substring(0, mathResult.value.length - 1);
    } else {
      mathResult.value = '0';
    }
  }

  calculatePercentage() {
    try {
      // Si hay paréntesis, no hacer porcentaje por ahora
      if (mathResult.value.contains('(') || mathResult.value.contains(')')) {
        return;
      }
      
      final number = double.tryParse(mathResult.value);
      if (number == null) return;

      final result = number / 100;
      mathResult.value = result.toString();
      _cleanResult();
    } catch (e) {
      mathResult.value = 'Error';
    }
  }

  _cleanResult() {
    if (mathResult.value.endsWith('.0')) {
      mathResult.value = mathResult.value.substring(0, mathResult.value.length - 2);
    }
  }

  calculateResult() {
    try {
      // Si contiene paréntesis, usar evaluación compleja
      if (mathResult.value.contains('(') || mathResult.value.contains(')')) {
        _evaluateExpression();
        return;
      }

      // Método tradicional para operaciones simples
      if (firstNumber.value != '0') {
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
        }
        
        _cleanResult();
        // Resetear para la siguiente operación
        firstNumber.value = '0';
        operation.value = '+';
      }
    } catch (e) {
      mathResult.value = 'Error';
      print('Error en cálculo: $e');
    }
  }

  void _evaluateExpression() {
    try {
      String expr = mathResult.value;
      
      // Auto-cerrar paréntesis faltantes
      int openCount = '('.allMatches(expr).length;
      int closeCount = ')'.allMatches(expr).length;
      for (int i = 0; i < openCount - closeCount; i++) {
        expr += ')';
      }
      
      print('Expresión a evaluar: $expr');
      
      // Reemplazar operadores
      expr = expr.replaceAll('x', '*');
      expr = expr.replaceAll('÷', '/');
      
      // Evaluar
      double result = _evaluate(expr);
      
      mathResult.value = result.toString();
      _cleanResult();
    } catch (e) {
      mathResult.value = 'Error';
      print('Error en evaluación: $e');
    }
  }

  double _evaluate(String expression) {
    expression = expression.replaceAll(' ', '');
    return _parseExpression(expression);
  }

  double _parseExpression(String expr) {
    if (expr.isEmpty) throw Exception('Expresión vacía');
    
    // Manejar suma y resta (menor precedencia)
    for (int i = expr.length - 1; i >= 0; i--) {
      if ((expr[i] == '+' || expr[i] == '-') && i > 0) {
        int depth = 0;
        for (int j = 0; j < i; j++) {
          if (expr[j] == '(') depth++;
          if (expr[j] == ')') depth--;
        }
        if (depth == 0) {
          // Evitar tratar números negativos como resta
          if (expr[i] == '-' && i > 0) {
            String prevChar = expr[i - 1];
            if (prevChar == '+' || prevChar == '-' || prevChar == '*' || 
                prevChar == '/' || prevChar == '^' || prevChar == '(') {
              continue; // Es un número negativo, no una resta
            }
          }
          
          double left = _parseExpression(expr.substring(0, i));
          double right = _parseExpression(expr.substring(i + 1));
          return expr[i] == '+' ? left + right : left - right;
        }
      }
    }

    // Manejar multiplicación y división
    for (int i = expr.length - 1; i >= 0; i--) {
      if ((expr[i] == '*' || expr[i] == '/') && i > 0) {
        int depth = 0;
        for (int j = 0; j < i; j++) {
          if (expr[j] == '(') depth++;
          if (expr[j] == ')') depth--;
        }
        if (depth == 0) {
          double left = _parseExpression(expr.substring(0, i));
          double right = _parseExpression(expr.substring(i + 1));
          if (expr[i] == '*') return left * right;
          if (right == 0) throw Exception('División por cero');
          return left / right;
        }
      }
    }

    // Manejar potencia (mayor precedencia)
    for (int i = expr.length - 1; i >= 0; i--) {
      if (expr[i] == '^' && i > 0) {
        int depth = 0;
        for (int j = 0; j < i; j++) {
          if (expr[j] == '(') depth++;
          if (expr[j] == ')') depth--;
        }
        if (depth == 0) {
          double left = _parseExpression(expr.substring(0, i));
          double right = _parseExpression(expr.substring(i + 1));
          return pow(left, right).toDouble();
        }
      }
    }

    // Manejar paréntesis
    if (expr.startsWith('(') && expr.endsWith(')')) {
      return _parseExpression(expr.substring(1, expr.length - 1));
    }

    // Manejar números negativos
    if (expr.startsWith('-')) {
      return -_parseExpression(expr.substring(1));
    }

    // Manejar números
    return double.parse(expr);
  }
}