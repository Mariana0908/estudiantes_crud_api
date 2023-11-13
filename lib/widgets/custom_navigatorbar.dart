import 'package:flutter/material.dart';
import 'package:notes_api_crud_app/models/estudiante_model.dart';
import 'package:notes_api_crud_app/services/estudiantes_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);
    final EstudiantesServicio estudiantesServicio =
        Provider.of(context, listen: false);
    final currentIndex = actualOptionProvider.selectedOption;

    return BottomNavigationBar(
      //Current Index, para determinar el botón que debe marcarse
      currentIndex: currentIndex,
      onTap: (int i) {
        if (i == 1) {
          estudiantesServicio.estudianteSeleccionado =
              Estudiante(documentoIdentidad: '', nombre: '', edad: '');
        }
        actualOptionProvider.selectedOption = i;
      },
      //Items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.list), label: "Listar Estudiantes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded), label: "Crear Estudiantes")
      ],
    );
  }
}
