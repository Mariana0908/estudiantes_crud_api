import 'package:flutter/material.dart';

import '../models/estudiante_model.dart';

class EstudiantesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Estudiante estudiante;

  EstudiantesFormProvider(this.estudiante);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
