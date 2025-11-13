import 'package:dio/dio.dart';
import 'package:examen/mensajeria/dominio/mesagge.dart';
import 'package:examen/mensajeria/infraestructura/get_yes_no_model.dart';

class GetAnswer {
  final _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      validateStatus: (status) => status! < 500,
    ),
  );

  Future<Message> getAnswer() async {
    try {
      print('🔄 Llamando a la API Yes/No...');

      final response = await _dio.get('https://yesno.wtf/api');

      print('✅ Respuesta recibida: ${response.statusCode}');
      print('📦 Datos: ${response.data}');

      if (response.statusCode == 200) {
        final getYesnoModel = GetYesNoModel.fromJsonMap(response.data);
        final message = getYesnoModel.toMessageEntity();

        print('💬 Mensaje creado: "${message.text}"');
        print('🖼️ URL Imagen: ${message.imageUrl}');

        return message;
      } else {
        print('⚠️ Status code no esperado: ${response.statusCode}');
        return _createErrorMessage('Error en la respuesta del servidor');
      }
    } on DioException catch (e) {
      print('❌ Error Dio: ${e.type}');
      print('❌ Mensaje: ${e.message}');

      if (e.type == DioExceptionType.connectionTimeout) {
        return _createErrorMessage('Se agotó el tiempo de espera');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return _createErrorMessage('Se agotó el tiempo de respuesta');
      } else if (e.type == DioExceptionType.connectionError) {
        return _createErrorMessage('Sin conexión a Internet');
      } else {
        return _createErrorMessage('Error de red');
      }
    } catch (e) {
      print('❌ Error general: $e');
      return _createErrorMessage('Error inesperado');
    }
  }

  Message _createErrorMessage(String errorText) {
    return Message(
      text: errorText,
      yooEl: YooEl.hers,
      imageUrl: null,
      createdAt: DateTime.now(), // 👈 ARREGLO: Se debe incluir la hora
    );
  }
}
