import 'package:hive/hive.dart';
import 'package:proyecto_pa/Modelo/Categoria.dart';

class HiveCategorias {
  final Box<Categoria> _categoriasBox;

  // Constructor para abrir la caja 'categorias'
  HiveCategorias() : _categoriasBox = Hive.box<Categoria>('categorias');

  // Agregar una nueva categoría usando el id (en formato '01', '02') como clave principal
  Future<bool> agregarCategoria(Categoria categoria) async {
    String idClave = categoria.id.toString().padLeft(2, '0'); // Convertir id a formato '01', '02', etc.
    if (_categoriasBox.containsKey(idClave)) {
      print('Error: Ya existe una categoría con ese ID.');
      return false;
    }

    await _categoriasBox.put(idClave, categoria); // Usar el id formateado como clave
    return true;
  }

  // Eliminar una categoría por ID en formato '01', '02', etc.
  Future<void> eliminarCategoria(int id) async {
    String idClave = id.toString().padLeft(2, '0');
    await _categoriasBox.delete(idClave);
  }

  // Eliminar todas las categorías
  Future<void> eliminarTodasCategorias() async {
    await _categoriasBox.clear(); // Elimina todos los registros de la caja
  }

  // Actualizar una categoría existente usando su ID en formato '01', '02', etc.
  Future<bool> actualizarCategoria(Categoria categoriaActualizada) async {
    String idClave = categoriaActualizada.id.toString().padLeft(2, '0');
    if (_categoriasBox.containsKey(idClave)) {
      await _categoriasBox.put(idClave, categoriaActualizada);
      return true;
    } else {
      print('Error: No se encontró una categoría con ese ID.');
      return false;
    }
  }

  // Buscar una categoría por ID (en formato '01', '02', etc.)
  Categoria? buscarCategoria(int id) {
    String idClave = id.toString().padLeft(2, '0');
    return _categoriasBox.get(idClave);
  }

  // Obtener todas las categorías, ordenadas por ID (numéricamente pero en formato '01', '02', etc.)
  Future<List<Categoria>> obtenerTodasCategorias() async {
    List<Categoria> categorias = _categoriasBox.values.toList();
    
    // Ordenar las categorías por ID (respetando el formato de cadena '01', '02', etc.)
    categorias.sort((a, b) => a.id.compareTo(b.id));

    return categorias;
  }

  // Mostrar todas las categorías en consola
  Future<void> mostrarCategorias() async {
    List<Categoria> categorias = await obtenerTodasCategorias();
    for (var categoria in categorias) {
      print(categoria.toString());
    }
  }
}


