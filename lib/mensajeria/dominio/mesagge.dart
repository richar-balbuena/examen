// mesagge.dart

enum YooEl {me, hers}

class Message {
  final String text;
  final String? imageUrl;
  final YooEl yooEl;
  final DateTime createdAt; // 👈 NUEVO: Hora del mensaje

  Message({
    required this.text,
     this.imageUrl,
    required this.yooEl,
    required this.createdAt, // 👈 Se requiere
  });
}