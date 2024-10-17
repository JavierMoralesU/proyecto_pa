import 'package:flutter/material.dart';
import 'package:proyecto_pa/Modelo/User.dart';
import 'package:proyecto_pa/Utilidad/Alerta.dart';
import 'package:proyecto_pa/Utilidad/HiveUsuarios.dart';
import 'package:proyecto_pa/Vistas/VCategoria';


class VSesion extends StatefulWidget {
  const VSesion({super.key});

  @override
  _VSesionState createState() => _VSesionState();
}

class _VSesionState extends State<VSesion> {
  // Controladores para los campos de texto
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  String? _rolSeleccionado;

 @override
  void initState() 
  {
    super.initState();
    () async 
    {
      final datosInicio = await HiveUsuarios().obtenerUsuarioInicial();
      
      setState
      (() 
      {
        _usuarioController.text    = datosInicio['nombre']; // Asigna el nombre al TextField
        _contrasenaController.text = datosInicio['contrasena']; // Asigna la contraseña
        _rolSeleccionado           = datosInicio['rol']; // Asigna el rol al DropdownButton
      }
      );
    }();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:
        [
          // Primer contenedor con la imagen
          Container(height: 150,color: const Color(0xFF645cd6),alignment: Alignment.topCenter,
            child: Padding
            (
              padding: const EdgeInsets.only(top: 25.0),
              child: Image.asset('materiales/imagenes/I_titulo.png',height: 100,),
            ),
          ),

          // Segundo contenedor con el contenido que llena el resto de la pantalla
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF94acfa),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text('Rol',
                          style: TextStyle(fontSize: 20, color: Color(0xff151823))),
                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: _rolSeleccionado, // Usa la variable para el valor actual
                        hint: const Text('Selecciona un rol'),
                        items: const [
                          DropdownMenuItem(value: 'Administrador', child: Text('Administrador')),
                          DropdownMenuItem(value: 'Vendedor', child: Text('Vendedor')),
                        ],
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        onChanged: (value) {
                          setState(() {
                            _rolSeleccionado = value; // Actualiza el valor seleccionado
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffD9D9D9),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text('Usuario', style: TextStyle(fontSize: 20, color: Color(0xff151823))),
                      const SizedBox(height: 10),

                      // Campo de texto para el nombre
                      TextField(
                        controller: _usuarioController, // Asigna el controlador
                        decoration: const InputDecoration(
                          labelStyle:  TextStyle(color: Color(0xff1D1B20)),
                          border:  OutlineInputBorder(),
                          filled: true,
                          fillColor:  Color(0xffD9D9D9),
                        ),
                        style: const TextStyle(fontSize: 16.0, color: Colors.black),
                      ),

                      const SizedBox(height: 20),
                      const Text('Contraseña', style: TextStyle(fontSize: 20, color: Color(0xff151823))),
                      const SizedBox(height: 10),

                      // Campo de texto para la contraseña
                      TextField(
                        controller: _contrasenaController, // Asigna el controlador
                        decoration: const InputDecoration(
                          labelStyle:  TextStyle(color: Color(0xff1D1B20)),
                          border:  OutlineInputBorder(),
                          filled: true,
                          fillColor:  Color(0xffD9D9D9),
                        ),
                        style: const TextStyle(fontSize: 16.0, color: Colors.black),
                      ),

                      const SizedBox(height: 30),

                      Center(
                        child: Column(
                          children: [
                            ElevatedButton
                            (
                              onPressed: _iniciarSesion,
                              style: ElevatedButton.styleFrom
                              (
                                backgroundColor: const Color(0XFF725BF8),
                                minimumSize: const Size(400, 70),
                                shape: const RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Text
                              (
                                'INICIAR',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            //______________________________Segundo Botón______________________________
                            ElevatedButton(
                              onPressed: () { // Limpiar campos
                                
                                setState(() {
                                  _usuarioController.clear(); 
                                  _contrasenaController.clear(); 
                                  _rolSeleccionado = null; 
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0XFF7C6CD9),
                                minimumSize: const Size(400, 70),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Text(
                                'Limpiar',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            //_______________________________Imagen de la tienda_____________________________
                            Image.asset('materiales/imagenes/Imagen_tiendita.png',
                                height: 200),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Método separado para manejar la lógica de inicio de sesión
  Future<void> _iniciarSesion() async 
  {
    final String nombreUsuario = _usuarioController.text.trim();
    final String contrasena = _contrasenaController.text.trim();
    final String rol = _rolSeleccionado!;
    final usuarioEncontrado = HiveUsuarios().buscarUsuario(nombreUsuario);

    if (usuarioEncontrado != null && usuarioEncontrado.rol == rol) // Si el usuario existe
    {
          if (usuarioEncontrado.contrasena == contrasena) // Si la contraseña es correcta
          {

              Usuario nuevoUsuario = Usuario
              (
               rol: usuarioEncontrado.rol,
               nombre: usuarioEncontrado.nombre,
               contrasena: usuarioEncontrado.contrasena,
              );
            if (rol == 'Administrador') 
            {
            } 
            else 
            {
            }
             await HiveUsuarios().actualizarUsuarioInicial(usuario: nuevoUsuario);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  VCategoria  ()));
              //CategoriasPage ()
          }   
          else 
          {
            Alerta.mostrar(context, 'Contraseña incorrecta.');
          }             
    }  
    else 
    {
      Alerta.mostrar(context, 'Usuario no encontrado, o rol incorrecto.');
    }   
  } 
     
}
