import 'package:flutter/material.dart';

class Alerta {
  // Este método estático muestra una alerta con un mensaje dado
  static Future<void> mostrar(BuildContext context, String mensaje) async 
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Evita que se cierre al tocar fuera de la alerta
      builder: (BuildContext context) 
      {
        return AlertDialog
        (
          title: const Text('Alerta'),
          content: Text(mensaje),
          actions: <Widget>
          [
            TextButton
            (
              child: const Text('OK'),
              onPressed: () 
              {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }
}
