import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen/mensajeria/dominio/mesagge.dart';
import 'package:examen/mensajeria/presentacion/provider/chat_provider.dart';
import 'package:examen/mensajeria/presentacion/widgets/my_message_buble.dart';
import 'package:examen/mensajeria/presentacion/widgets/otros_message_buble.dart';
import 'package:examen/mensajeria/presentacion/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  // Colores de WhatsApp
  static const Color whatsappGreen = Color(0xFF075E54);
  static const Color whatsappDarkBg = Color(0xFF0D1418); // Color de fondo oscuro

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Scaffold(
      backgroundColor: whatsappDarkBg,
      appBar: AppBar(
        backgroundColor: whatsappGreen,
        elevation: 2,
        
        // Botón de atrás
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        
        titleSpacing: 0,
        // Al tocar el perfil o el nombre, se abre el diálogo para cambiar de contacto
        title: GestureDetector(
          onTap: () => _showProfileDialog(context, chatProvider),
          child: Row(
            children: [
              Hero(
                tag: 'profile_pic',
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(chatProvider.currentProfileImage),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatProvider.contactName, // Nombre dinámico
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      chatProvider.isOnline ? 'En línea' : 'desconectado',
                      style: TextStyle(
                        fontSize: 12,
                        color: chatProvider.isOnline ? Colors.greenAccent : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Botones de acción y menú de opciones
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'profile') {
                _showProfileDialog(context, chatProvider);
              } else if (value == 'clear') {
                chatProvider.clearChat();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('Cambiar perfil'),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Text('Limpiar chat'),
              ),
            ],
          ),
        ],
      ),
      body: _Chatview(),
    );
  }

  // Diálogo para cambiar de perfil (función que proporcionaste)
  void _showProfileDialog(BuildContext context, ChatProvider chatProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1F2C34),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Seleccionar contacto',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: chatProvider.availableProfiles.length,
                    itemBuilder: (context, index) {
                      final profile = chatProvider.availableProfiles[index];
                      return GestureDetector(
                        onTap: () {
                          chatProvider.changeProfile(profile['url']!, profile['name']!);
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(profile['url']!),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              profile['name']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Color(0xFF25D366)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Chatview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Stack(
      children: [
        // 1. Imagen de fondo
        Positioned.fill(
          child: Opacity(
            opacity: 0.15, // Transparencia para que se vean los mensajes
            
            child: Image.asset(
              // **RUTA CORREGIDA** (Asegúrate que esta ruta exista en pubspec.yaml)
              'assets/images/fondo-de-pantalla-azul.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Si no encuentra la imagen, mostrar degradado oscuro
                return Container(
                  color: const Color.fromARGB(74, 154, 190, 210),
                );
              },
            ),
          ),
        ),
        
        // 2. Contenido del chat
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messageList[index];
                      // Verificar si es el último mensaje para el "visto"
                      final isLastMessage = index == chatProvider.messageList.length - 1;
                      final isMyMessage = message.yooEl == YooEl.me;

                      return Column(
                        children: [
                          if (isMyMessage)
                            MyMessageBuble(
                              message: message,
                              showCheck: isLastMessage, // Mostrar check solo en el último mensaje
                              isRead: chatProvider.isLastMessageRead, // Color del check
                            )
                          else
                            OtrosMessaheBuble(message: message),
                        ],
                      );
                    },
                  ),
                ),
                
                // 3. Campo de texto con color de fondo oscuro
                Container(
                  color: const Color.fromARGB(110, 225, 238, 245), // Fondo oscuro para la caja de texto
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: MessageFieldBox(
                    onValue: (value) => chatProvider.sendMessage(value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}