import 'package:flutter/material.dart';
import 'package:proyecto_pa/Modelo/Categoria.dart';
import 'package:proyecto_pa/Utilidad/HiveCategorias.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  final HiveCategorias manager = HiveCategorias();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    nombreController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  Future<void> _agregarCategoria() async {
    final String id = idController.text.trim();
    final String nombre = nombreController.text.trim();
    final String descripcion = descripcionController.text.trim();

    if (id.isNotEmpty && nombre.isNotEmpty && descripcion.isNotEmpty) {
      final int idNumerico = int.tryParse(id) ?? -1;
      if (idNumerico < 0) {
        _mostrarSnackBar('ID inválido. Debe ser un número.');
        return;
      }

      final categoria = Categoria(
        id: idNumerico, 
        nombre: nombre, 
        descripcion: descripcion
      );
      final bool exito = await manager.agregarCategoria(categoria);

      if (exito) {
        _limpiarCampos();
        setState(() {}); // Actualiza la UI si la operación fue exitosa
      } else {
        _mostrarSnackBar('El ID de la categoría ya existe.');
      }
    } else {
      _mostrarSnackBar('Todos los campos son obligatorios.');
    }
  }

  Future<void> _borrarTodasCategorias() async {
    await manager.eliminarTodasCategorias();
    setState(() {});
  }

  void _limpiarCampos() {
    idController.clear();
    nombreController.clear();
    descripcionController.clear();
  }

  void _mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Categorías'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextFields para agregar datos
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID (número)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 20),
              // Botones para agregar y borrar categorías
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _agregarCategoria,
                    child: const Text('Agregar Categoría'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _borrarTodasCategorias,
                    style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Borrar Todas'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // ListView para mostrar las categorías
              FutureBuilder<List<Categoria>>(
                future: manager.obtenerTodasCategorias(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final categorias = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categorias.length,
                      itemBuilder: (context, index) {
                        final categoria = categorias[index];
                        return ListTile(
                          title: Text(categoria.nombre),
                          subtitle: Text('ID: ${categoria.id}, Descripción: ${categoria.descripcion}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                manager.eliminarCategoria(categoria.id);
                              });
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No hay categorías.'));
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
