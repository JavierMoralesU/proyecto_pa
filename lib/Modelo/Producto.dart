import 'package:hive/hive.dart';

part 'Producto.g.dart'; // Asegúrate de que este nombre coincida con tu archivo generado

@HiveType(typeId: 2) // Asegúrate de que el typeId sea único
class Producto extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nombre;

  @HiveField(2)
  String categoria;

  @HiveField(3)
  int cantidad;

  @HiveField(4)
  int precioC; // Precio de compra

  @HiveField(5)
  int precioV; // Precio de venta

  // Constructor
  Producto({
    required this.id,
    String? nombre,
    String? categoria,
    int? cantidad,
    int? precioC,
    int? precioV,
  })  : nombre = nombre ?? 'p$id', // Si nombre es nulo, usa 'p{id}'
        categoria = categoria ?? 'ninguna', // Si categoria es nula, usa 'ninguna'
        cantidad = cantidad ?? 0, // Si cantidad es nula, usa 0
        precioC = precioC ?? -1,  // Si precioC es nulo, usa -1
        precioV = precioV ?? -1;  // Si precioV es nulo, usa -1

  @override
  String toString() {
    return 'Producto(id: $id, nombre: $nombre, categoria: $categoria, cantidad: $cantidad, precioC: $precioC, precioV: $precioV)';
  }
}
