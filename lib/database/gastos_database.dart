import 'package:expense_tracker_app/models/gasto.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class GastosDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Gasto> _allGastos = [];

  /*  SETUP  */
  // Inicializacion de la BD

  static Future<void> initialize() async {
    final dir =
        await getApplicationDocumentsDirectory(); // Obtenemos directorio de trabajo
    isar = await Isar.open([GastoSchema],
        directory:
            dir.path); // Inicializa la bd y la almacena en una ruta local.
  }

  /*  GETTERS  */
  //
  List<Gasto> get allGastos => _allGastos;

  /*  OPERATIONS  */
  // Seccion de CRUD

  // Crea un nuevo gasto.
  Future<void> crearGasto(Gasto nuevoGasto) async {
    await isar.writeTxn(() => isar.gastos.put(nuevoGasto));

    await leerGasto();
  }

  // Lectura de gastos.
  Future<void> leerGasto() async {
    // Obtenemos los gastos de la bd.
    List<Gasto> listadoGastos = await isar.gastos.where().findAll();

    // Limpiamos el objeto contenedor e incluimos los nuevos valores.
    _allGastos.clear();
    _allGastos.addAll(listadoGastos);

    // Actualizamos la interfaz de usuario
    notifyListeners();
  }

  // Actualizacion de gastos.
  Future<void> updateGasto(int id, Gasto itemGasto) async {
    itemGasto.id = id;
    // Actualizamos el gasto que posea mismo id.
    await isar.writeTxn(() => isar.gastos.put(itemGasto));

    // Obtenemos nuevo listado de gastos.
    await leerGasto();
  }

  // Borramos un gasto.
  Future<void> deleteGasto(int id) async {
    // Eliminamos de la bd.
    await isar.writeTxn(() => isar.gastos.delete(id));

    // Obtenemos nuevo listado de gastos.
    await leerGasto();
  }

  /*  HELPERS  */
  // Inicializacion de la BD
}
