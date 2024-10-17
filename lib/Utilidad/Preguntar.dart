import 'package:flutter/material.dart';
import 'package:proyecto_pa/Modelo/Categoria.dart';

class Preguntar {
  // Este método estático muestra un diálogo de confirmación con un mensaje dado
  static Future<bool> mostrar(BuildContext context, String mensaje) async 
  {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // Evita que se cierre al tocar fuera de la alerta
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); // Retorna false al pulsar No
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop(true); // Retorna true al pulsar Sí
              },
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Asegura que no sea null
  }

 // Método para mostrar una confirmación de eliminación de categorías
 // usado en VCategorias
  static Future<bool> mostrarConfirmacionEliminar(BuildContext context, List<Categoria> seleccionadas) async {
    // Obtén la cantidad de elementos a eliminar
    int cantidad = seleccionadas.length;

    // Obtén los nombres de las categorías a eliminar
    String nombres = seleccionadas.map((c) => c.nombre).join(', ');

    // Crea el mensaje para el diálogo
    String mensaje = '¿Estás seguro de que deseas eliminar $cantidad categoría(s): $nombres?';

    // Utiliza el método de Preguntar para mostrar la confirmación
    return mostrar(context, mensaje); // Llama al método mostrar
  }


}


