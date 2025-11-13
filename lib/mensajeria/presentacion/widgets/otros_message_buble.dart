import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:examen/mensajeria/dominio/mesagge.dart';

class OtrosMessaheBuble extends StatelessWidget {
  const OtrosMessaheBuble({
    super.key, 
    required this.message
  });
  
  final Message message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 5),
        
        // Solo mostrar imagen si existe
        if (message.imageUrl != null && message.imageUrl!.isNotEmpty)
          _ImageBubble(imageUrl: message.imageUrl!),
        
        const SizedBox(height: 10),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble({
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size.width * 0.7,
        height: 150,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: size.width * 0.7,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                Text(
                  'Cargando GIF...',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          print('❌ Error cargando imagen: $error');
          print('🔗 URL que falló: $url');
          
          return Container(
            width: size.width * 0.7,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.gif_box_outlined,
                  size: 50,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 10),
                Text(
                  'GIF no disponible',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'La imagen no pudo cargarse',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}