import 'package:flutter/material.dart';
import 'package:examen/mensajeria/dominio/mesagge.dart';
import 'package:examen/mensajeria/config/helpers/get_answer.dart';

class ChatProvider extends ChangeNotifier {
  final GetAnswer getAnswer = GetAnswer();
  final ScrollController chatScrollController = ScrollController();

  List<Message> messageList = [];
  
  // LOGICA PARA EL "VISTO"
  bool isLastMessageRead = false; // 👈 Propiedad para el estado de visto

  // PROPIEDADES USADAS EN CHATSCREEN.DART
  final List<Map<String, String>> availableProfiles = const [
    {'name': 'Spidey', 'url': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYrXJbwhwO94iECP0qUzvI3aTU55n4PLRSqQ&s'},
    {'name': 'Gwen Stacy', 'url': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7uN7Yf1Xw1X5sYp5Q5f1t0o9t4q3f1v4Q5w&s'},
    {'name': 'Miles', 'url': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYrXJbwhwO94iECP0qUzvI3aTU55n4PLRSqQ&s'},
  ];

  String contactName = 'Spidey';
  String currentProfileImage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYrXJbwhwO94iECP0qUzvI3aTU55n4PLRSqQ&s';
  bool isOnline = true;
  
  // FUNCIONES DEL CHAT
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    
    // Al enviar, se resetea el estado de leído.
    isLastMessageRead = false; 

    final newMessage = Message(
      text: text,
      yooEl: YooEl.me,
      createdAt: DateTime.now(), // 👈 Ahora se requiere
    );

    messageList.add(newMessage);
    notifyListeners();
    moveScrollToButtom();
    
    if (text.endsWith('!')) {
      await herReply();
    }
  }

  Future<void> herReply() async {
    try {
      final herMessage = await getAnswer.getAnswer();
      messageList.add(herMessage);
      
      // LOGICA DE VISTO: El mensaje del otro (herReply) marca el mensaje anterior como leído
      markLastMessageAsRead(); 

      notifyListeners();
      moveScrollToButtom();
    } catch (e) {
      print('Error al obtener respuesta: $e');
      final errorMessage = Message(
        text: 'Error al obtener respuesta',
        yooEl: YooEl.hers,
        imageUrl: null,
        createdAt: DateTime.now(),
      );
      messageList.add(errorMessage);
      notifyListeners();
    }
  }
  
  // NUEVA FUNCIÓN PARA CAMBIAR EL VISTO
  void markLastMessageAsRead() {
    isLastMessageRead = true;
    notifyListeners();
  }

  void moveScrollToButtom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    // Si el controlador está unido, mover al final
    if (chatScrollController.hasClients) {
      chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  
  // FUNCIONES DE CHATSCREEN.DART
  void changeProfile(String url, String name) {
    contactName = name;
    currentProfileImage = url;
    notifyListeners();
  }

  void clearChat() {
    messageList.clear();
    isLastMessageRead = false; // Resetear el visto al limpiar
    notifyListeners();
  }
}