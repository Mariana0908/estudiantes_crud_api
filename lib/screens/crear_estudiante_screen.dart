import 'package:flutter/material.dart';
import 'package:notes_api_crud_app/services/estudiantes_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';
import '../providers/estudiantes_form_provider.dart';

class CrearEstudianteVista extends StatelessWidget {
  const CrearEstudianteVista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EstudiantesServicio estudianteService = Provider.of(context);

    //Creando un provider solo enfocado al formulario
    return ChangeNotifierProvider(
        create: (_) =>
            EstudiantesFormProvider(estudianteService.estudianteSeleccionado),
        child: _CreateForm(estudianteService: estudianteService));
  }
}

class _CreateForm extends StatelessWidget {
  final EstudiantesServicio estudianteService;

  const _CreateForm({required this.estudianteService});

  @override
  Widget build(BuildContext context) {
    final EstudiantesFormProvider estudiantesFormProvider =
        Provider.of<EstudiantesFormProvider>(context);

    final estudiante = estudiantesFormProvider.estudiante;

    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: estudiantesFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: estudiante.nombre,
            decoration: const InputDecoration(
                hintText: 'Escriba su nombre',
                labelText: 'Nombre',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) =>
                estudiantesFormProvider.estudiante.nombre = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            initialValue: estudiante.documentoIdentidad,
            decoration: const InputDecoration(
              hintText: 'Digite el documento de identidad', //pista o plcaholder
              labelText: 'Documento de identidad',
            ),
            onChanged: (value) => estudiante.documentoIdentidad = value,
            validator: (value) {
              return (value != null)
                  ? null
                  : 'ingrese su documento de identidad, no puede estar vacío';
            },
          ),
          TextFormField(
            autocorrect: false,
            initialValue: estudiante.edad,
            decoration: const InputDecoration(
              hintText: 'Digite su edad', //pista o placeholder
              labelText: 'Edad',
            ),
            onChanged: (value) => estudiante.edad = value,
            validator: (value) {
              return (value != null)
                  ? null
                  : 'ingrese su edad, no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: estudianteService.isSaving
                ? null
                : () async {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!estudiantesFormProvider.isValidForm()) return;
                    await estudianteService
                        .crearOActualizar(estudiantesFormProvider.estudiante);
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  estudianteService.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
