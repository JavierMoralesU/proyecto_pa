import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyecto_pa/Modelo/Categoria.dart';
import 'package:proyecto_pa/Modelo/Producto.dart';
import 'package:proyecto_pa/Modelo/User.dart';
import 'package:proyecto_pa/Vistas/VSesion.dart';







void main() async { // RAMA 1 E
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive
  await Hive.initFlutter();

  // Registrar los adaptadores para las clases Usuario, Categoria y Producto
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(CategoriaAdapter() ); 
   Hive.registerAdapter(ProductoAdapter() );

  // Abrir las cajas (boxes) de usuarios, categorías y productos
  await Hive.openBox<Usuario>('usuarios');
  await Hive.openBox<Categoria> ('categorias'); 
  await Hive.openBox<Producto> ('productos'); 


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



