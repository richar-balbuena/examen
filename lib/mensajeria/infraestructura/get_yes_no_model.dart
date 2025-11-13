import 'package:examen/mensajeria/dominio/mesagge.dart';

class GetYesNoModel {
  final String answer;
  final bool forced;
  final String image;
  

  GetYesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });


//cambiar a fromJson Map
  factory GetYesNoModel.fromJsonMap(Map<String, dynamic> json) => GetYesNoModel(
        answer: json['answer'],
        forced: json['forced'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'answer': answer,
        'forced': forced,
        'image': image,
      };


  Message toMessageEntity() => Message(
        text: answer == 'yes' ? 'Si' : 'No',
        yooEl: YooEl.hers,
        imageUrl: image,
        createdAt: DateTime.now(), // <--- CAMBIO CRÍTICO: Añadir hora
      );
}