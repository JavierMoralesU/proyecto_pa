import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyecto_pa/Modelo/Categoria.dart';
import 'package:proyecto_pa/Modelo/User.dart';
import 'package:proyecto_pa/Vistas/VCategoria';
import 'package:proyecto_pa/Vistas/VSesion.dart';







void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive
  await Hive.initFlutter();

  // Registrar el adaptador para la clase Usuario
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(CategoriaAdapter() );// quitar?

  // Abrir la caja (box) de usuarios
  await Hive.openBox<Usuario>('usuarios');
  await Hive.openBox<Categoria> ('categorias'); // quitar?

  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
   
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    home:  VSesion (),
      
    );
  }
}



