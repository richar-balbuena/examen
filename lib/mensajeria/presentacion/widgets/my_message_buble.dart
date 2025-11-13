import "package:flutter/material.dart";
import 'package:examen/mensajeria/dominio/mesagge.dart';
import 'package:intl/intl.dart'; // 👈 Importar intl

class MyMessageBuble extends StatelessWidget {
  final Message message;
  final bool showCheck; // Indica si es el último mensaje (debe mostrar el check)
  final bool isRead;    // Indica si el mensaje ha sido leído (color del check)

  const MyMessageBuble({
    super.key, 
    required this.message,
    required this.showCheck, // 👈 Requerido
    required this.isRead,    // 👈 Requerido
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    // Formato de hora (ej: 10:30 PM)
    final timeFormat = DateFormat('h:mm a').format(message.createdAt);

    return Padding( 
      padding: const EdgeInsets.only(bottom: 8), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 1. La Burbuja de Mensaje
          Container(
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.9), // Color ligeramente ajustado
              borderRadius: BorderRadius.circular(9),
            ),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: Text(
                message.text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          
          const SizedBox(height: 4),

          // 2. Hora y Estado de Visto
          Row(
            mainAxisSize: MainAxisSize.min, // Ocupa solo el espacio de los hijos
            children: [
              Text(
                timeFormat, // Hora
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white54,
                ),
              ),
              
              // Mostrar el ícono solo si showCheck es true (es el último mensaje)
              if (showCheck) 
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(
                    Icons.done_all, // Icono de doble check
                    size: 14,
                    // Color azul si isRead es true, gris tenue si no
                    color: isRead ? Colors.lightBlueAccent : Colors.white54, 
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}