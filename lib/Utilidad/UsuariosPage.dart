import 'package:flutter/material.dart';
import 'package:proyecto_pa/Modelo/User.dart';
import 'package:proyecto_pa/Utilidad/HiveUsuarios.dart';


class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final HiveUsuarios manager = HiveUsuarios();
  final TextEditingController rolController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  @override
  void dispose() {
    rolController.dispose();
    nombreController.dispose();
    contrasenaController.dispose();
    super.dispose();
  }

  Future<void> _agregarUsuario() async {
    final String rol = rolController.text.trim();
    final String nombre = nombreController.text.trim();
    final String contrasena = contrasenaController.text.trim();

    if (rol.isNotEmpty && nombre.isNotEmpty && contrasena.isNotEmpty) {
      final usuario = Usuario(rol: rol, nombre: nombre, contrasena: contrasena);
      final bool exito = await manager.agregarUsuario(usuario);
      
      if (exito) {
        _limpiarCampos();
        setState(() {}); // Actualiza la UI si la operación fue exitosa
      } else {
        _mostrarSnackBar('El nombre del usuario ya existe.');
      }
    } else {
      _mostrarSnackBar('Todos los campos son obligatorios.');
    }
  }

  Future<void> _borrarTodosUsuarios() async {
    await manager.eliminarTodosUsuarios();
    setState(() {});
  }

  void _limpiarCampos() {
    rolController.clear();
    nombreController.clear();
    contrasenaController.clear();
  }

  void _mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextFields para agregar datos
              TextField(
                controller: rolController,
                decoration: const InputDecoration(labelText: 'Rol'),
              ),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: contrasenaController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Botones para agregar y borrar usuarios
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _agregarUsuario,
                    child: const Text('Agregar Usuario'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _borrarTodosUsuarios,
                    style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Borrar Todos'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // ListView para mostrar los usuarios
              FutureBuilder<List<Usuario>>(
                future: manager.obtenerTodosUsuarios(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final usuarios = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: usuarios.length,
                      itemBuilder: (context, index) {
                        final usuario = usuarios[index];
                        return ListTile(
                          title: Text(usuario.nombre),
                          subtitle: Text('Rol: ${usuario.rol}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                manager.eliminarUsuario(usuario.nombre);
                              });
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No hay usuarios.'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
