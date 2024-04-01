import 'package:isar/isar.dart';

// Esta linea permite crear el archivo isar
// Correr el siguiente comando: dart run build_runner build
part 'expense.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  final String name;
  final double amount;
  final DateTime date;

  Expense({required this.name, required this.amount, required this.date});
}
