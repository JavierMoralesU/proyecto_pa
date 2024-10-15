import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject {
  @HiveField(0)
  String rol;

  @HiveField(1)
  String nombre;

  @HiveField(2)
  String contrasena;

  Usuario({
    required this.rol,
    required this.nombre,
    required this.contrasena,
  });

  @override
  String toString() {
    return 'Usuario(rol: $rol, nombre: $nombre)';
  }
}
