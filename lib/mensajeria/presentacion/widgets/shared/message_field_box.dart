import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    //controles para el aparado de texto
    final textController = TextEditingController();

    //mantener abierto el foco sin cerrar el terminar de escribir
    final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    //se almacena todo el diseño de los iconos
    final inputDecoration = InputDecoration(
      hintText: 'Escribe el mensaje desado',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: false,
      //realizar el onpressed para que reaccione al precionar el botoonn
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          //obtener el valor del texto ingresado
          final textValue = textController.value.text;
          //llamar al onvalue que se encuentra en el constructor
          onValue(textValue);
          //limpiar el textcontroller
          textController.clear();
        },
      ),
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        //llamar al onvalue que se encuentra en el constructor
        //valor del texto ingresado, submit
        onValue(value);
        //limpiar el textcontroller
        textController.clear();
        //mantener el foco en el textfield
        focusNode.requestFocus();
      },
    );
  }
}
