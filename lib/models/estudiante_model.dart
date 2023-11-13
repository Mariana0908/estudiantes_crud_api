// To parse this JSON data, do
//
//     final note = estudianteFromJson(jsonString);

import 'dart:convert';

Estudiante estudianteFromJson(String str) =>
    Estudiante.fromJson(json.decode(str));

String estudianteToJson(Estudiante data) => json.encode(data.toJson());

class Estudiante {
  String? id;
  String documentoIdentidad;
  String edad;
  String nombre;

  Estudiante({
    this.id,
    required this.documentoIdentidad,
    required this.edad,
    required this.nombre,
  });

  String toJson() => json.encode(toMap());

  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        id: json["id"],
        documentoIdentidad: json["documentoIdentidad"],
        edad: json["edad"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        // "id": id,
        "documentoIdentidad": documentoIdentidad,
        "edad": edad,
        "nombre": nombre,
      };
}
