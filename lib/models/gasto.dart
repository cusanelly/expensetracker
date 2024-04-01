import 'package:isar/isar.dart';

// Esta linea permite crear el archivo isar
// Correr el siguiente comando: dart run build_runner build
part 'gasto.g.dart';

@Collection()
class Gasto {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  final String nombre;
  final double monto;
  final DateTime fecha;

  Gasto({required this.nombre, required this.monto, required this.fecha});
}
