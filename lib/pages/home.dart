import 'package:expense_tracker_app/database/gastos_database.dart';
import 'package:expense_tracker_app/hekper/helper_functions.dart';
import 'package:expense_tracker_app/models/gasto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController montoController = TextEditingController();

  @override
  void initState() {
    Provider.of<GastosDatabase>(context, listen: false).leerGasto();
    super.initState();
  }

  void abrirDialogNuevoGasto() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Nuevo Gasto."),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nombre input
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(hintText: "Nombre"),
                  ),
                  // monto input
                  TextField(
                    controller: montoController,
                    decoration: const InputDecoration(hintText: "Monto"),
                  ),
                ],
              ),

              // Administra los botones de acciones del formulario.
              actions: [_cancelButton(), _saveButton()],
            ));
  }

  @override
  Widget build(BuildContext context) {
    // Widget que permite adherir una fuente a los widgets para su consumo.
    return Consumer<GastosDatabase>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: abrirDialogNuevoGasto,
          child: const Icon(Icons.add),
        ),
        // Widget de vista de listado.
        body: ListView.builder(
            itemCount: value.allGastos.length,
            itemBuilder: (context, index) {
              // Obtenemos los gastos de forma individual.
              Gasto gastoItem = value.allGastos[index];

              // retornamos item a la pantalla.
              return ListTile(
                title: Text(gastoItem.nombre),
                trailing: Text(formatMonto(gastoItem.monto)),
              );
            }),
      ),
    );
  }

  // Boton de cancelar.
  Widget _cancelButton() {
    return MaterialButton(
        onPressed: () {
          Navigator.pop(context);
          nombreController.clear();
          montoController.clear();
        },
        child: const Text("Cancel"));
  }

  // Boton de salvar gasto.
  Widget _saveButton() {
    return MaterialButton(
        onPressed: () async {
          if (nombreController.text.isNotEmpty &&
              montoController.text.isNotEmpty) {
            Navigator.pop(context);

            // Creamos nuevo objeto con los valores ingresados por el usuario.
            Gasto nuevoGasto = Gasto(
                nombre: nombreController.text,
                monto: convertStringToDouble(montoController.text),
                fecha: DateTime.now());
            // Salvamos valores en la base de datos.
            await context.read<GastosDatabase>().crearGasto(nuevoGasto);

            // Vaciamos los valores del formulario.
            nombreController.clear();
            montoController.clear();
          }
        },
        child: const Text("Save"));
  }
}
