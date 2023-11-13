import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/estudiante_model.dart';

class EstudiantesServicio extends ChangeNotifier {
  //Asignamos la url base a un atributo para accceder a él facilmente.

  final String _baseUrl = "pruebadm-59667-default-rtdb.firebaseio.com";

  late Estudiante estudianteSeleccionado;

  List<Estudiante> estudiantes = [];

  bool isLoading = false;
  bool isSaving = false;

  EstudiantesServicio() {
    cargarEstudiantes();
  }

  Future<List<Estudiante>> cargarEstudiantes() async {
    isLoading = true;
    notifyListeners();

    //Creamos la url a donde vamos a generar la solicitud
    final url = Uri.https(_baseUrl, 'estudiantes.json');
    final resp = await http.get(url);
    final Map<String, dynamic> estudiantesMap = json.decode(resp.body);
    print(estudiantesMap);

    estudiantesMap.forEach((key, value) {
      Estudiante estudianteTemporal = Estudiante.fromJson(value);
      estudianteTemporal.id = key;
      estudiantes.add(estudianteTemporal);
    });

    isLoading = false;
    notifyListeners();
    print("hola ${this.estudiantes}");
    return estudiantes;
  }

  Future crearOActualizar(Estudiante estudiante) async {
    isSaving = true;

    if (estudiante.id == null) {
      await crearEstudiante(estudiante);
    } else {
      await actualizarEstudiante(estudiante);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> crearEstudiante(Estudiante estudiante) async {
    isSaving = true;
    final url = Uri.https(_baseUrl, 'estudiantes.json');
    final resp = await http.post(url, body: estudiante.toJson());

    final decodedData = json.decode(resp.body);

    estudiante.id = decodedData['name'];

    estudiantes.add(estudiante);

    return estudiante.id!;
  }

  Future<String> actualizarEstudiante(Estudiante estudiante) async {
    isSaving = true;
    final url = Uri.https(_baseUrl, 'estudiantes.json');
    final resp = await http.put(url, body: estudiante.toJson());
    final decodedData = json.decode(resp.body);

    final index =
        estudiantes.indexWhere((element) => element.id == estudiante.id);

    estudiantes[index] = estudiante;

    return estudiante.id!;
  }

  Future<String> eliminarEstudiantePorId(String id) async {
    isLoading = true;
    final url = Uri.https(_baseUrl, 'estudiantes/$id.json');
    print(id);
    final resp = await http.delete(url, body: {"name": id});

    final decodedData = json.decode(resp.body);

    cargarEstudiantes();
    return id;
  }
}
