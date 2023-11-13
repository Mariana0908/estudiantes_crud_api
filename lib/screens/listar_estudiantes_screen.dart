import 'package:flutter/material.dart';
import 'package:notes_api_crud_app/services/estudiantes_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';

class ListarEstudiantesVista extends StatelessWidget {
  const ListarEstudiantesVista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ListarEstudiantes();
  }
}

class _ListarEstudiantes extends StatelessWidget {
  void displayDialog(
      BuildContext context, EstudiantesServicio estudianteServicio, String id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Eliminar'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿Desea eliminar de forma permanente el registro?'),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    estudianteServicio.eliminarEstudiantePorId(id);
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    EstudiantesServicio estudianteServicio =
        Provider.of<EstudiantesServicio>(context);
    // estudianteServicio.cargarEstudiantes();
    final estudiantes = estudianteServicio.estudiantes;

    return ListView.builder(
      itemCount: estudiantes.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.note),
        title: Text(estudiantes[index].nombre),
        subtitle: Text(estudiantes[index].id.toString()),
        trailing: PopupMenuButton(
          // icon: Icon(Icons.fire_extinguisher),
          onSelected: (int i) {
            if (i == 0) {
              estudianteServicio.estudianteSeleccionado = estudiantes[index];
              Provider.of<ActualOptionProvider>(context, listen: false)
                  .selectedOption = 1;
              return;
            }

            displayDialog(context, estudianteServicio, estudiantes[index].id!);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 0, child: Text('Actualizar')),
            const PopupMenuItem(value: 1, child: Text('Eliminar'))
          ],
        ),
      ),
    );
  }
}
