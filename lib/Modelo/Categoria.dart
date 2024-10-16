import 'package:hive/hive.dart';

part 'Categoria.g.dart'; // Asegúrate de que este nombre coincida con tu archivo de salida

@HiveType(typeId: 1) // Cambia el typeId a uno único
class Categoria extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nombre;

  @HiveField(2)
  String descripcion;

  Categoria({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  @override
  String toString() {
    return 'Categoria(id: $id, nombre: $nombre, descripcion: $descripcion)';
  }
}
