import 'package:hive/hive.dart';
import 'package:proyecto_pa/Modelo/User.dart';

class HiveUsuarios {
  final Box<Usuario> _usuariosBox;

  HiveUsuarios() : _usuariosBox = Hive.box<Usuario>('usuarios');


  Future<bool> agregarUsuario(Usuario usuario) async {
    if (_usuariosBox.containsKey(usuario.nombre)) {
      print('Error: Ya existe un usuario con ese nombre.');
      return false;
    }

    await _usuariosBox.put(usuario.nombre, usuario);
    return true;
  }

  Future<void> eliminarUsuario(String nombre) async {
    await _usuariosBox.delete(nombre);
  }

  Future<void> eliminarTodosUsuarios() async {
    await _usuariosBox.clear(); // Elimina todos los registros de la caja
  }

  

 Future<bool> actualizarUsuario(Usuario usuarioAnterior, Usuario usuarioActualizado) async 
 {
  // Si el nombre no cambia, simplemente actualiza el usuario
  if (usuarioAnterior.nombre == usuarioActualizado.nombre) {
    await _usuariosBox.put(usuarioAnterior.nombre, usuarioActualizado);
    return true;
  }

  // Si el nombre cambia, verifica que no exista otro usuario con el nuevo nombre
  if (_usuariosBox.containsKey(usuarioActualizado.nombre)) {
    print('Error: Ya existe un usuario con el nuevo nombre.');
    return false;
  }

  // Si el nombre cambió y no existe conflicto, elimina el registro antiguo y guarda el nuevo
  await _usuariosBox.delete(usuarioAnterior.nombre);
  await _usuariosBox.put(usuarioActualizado.nombre, usuarioActualizado);
  return true;
}

  Usuario? buscarUsuario(String nombre) {
    return _usuariosBox.get(nombre);
  }

 Future<List<Usuario>> obtenerTodosUsuarios() async {
  // Obtener la clave 'inicio'
  const claveInicio = 'inicio';

  // Convertir los usuarios a una lista filtrando el usuario con la clave 'inicio'
  List<Usuario> usuarios = _usuariosBox.keys
      .where((key) => key != claveInicio) // Filtrar la clave 'inicio'
      .map((key) => _usuariosBox.get(key)!)
      .toList();

  // Ordenar los usuarios por nombre
  usuarios.sort((a, b) => a.nombre.compareTo(b.nombre));

  return usuarios;
}



  Future<void> mostrarUsuarios() async {
    List<Usuario> usuarios = await obtenerTodosUsuarios();
    for (var usuario in usuarios) {
      print(usuario.toString());
    }
  }

   // Método para actualizar o crear el usuario inicial (clave 'inicio')
  Future<void> actualizarUsuarioInicial({Usuario? usuario}) async 
  {
    usuario ??= Usuario(rol: 'Administrador', nombre: 'admin', contrasena: 'admin123' );
    
    // Siempre se actualiza el usuario con clave 'inicio', sin importar el nombre
    await _usuariosBox.put('inicio', usuario);
  }

Future<Map<String, dynamic>> obtenerUsuarioInicial() async 
{
  const claveInicio = 'inicio';
  Usuario? usuarioInicial = _usuariosBox.get(claveInicio);

  if (usuarioInicial == null) { await actualizarUsuarioInicial(); usuarioInicial = _usuariosBox.get(claveInicio);}
  return 
  {
    'nombre': usuarioInicial?.nombre ?? '',
    'rol': usuarioInicial?.rol ?? '',
    'contrasena': usuarioInicial?.contrasena ?? ''
  };
}

}
