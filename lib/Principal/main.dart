import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyecto_pa/Modelo/User.dart';
import 'package:proyecto_pa/Utilidad/UsuariosPage.dart';

import 'package:proyecto_pa/Vistas/Vsesion.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive
  await Hive.initFlutter();

  // Registrar el adaptador para la clase Usuario
  Hive.registerAdapter(UsuarioAdapter());

  // Abrir la caja (box) de usuarios
  await Hive.openBox<Usuario>('usuarios');

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
    home: const VSesion (),
      
    );
  }
}



