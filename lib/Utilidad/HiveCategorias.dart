import 'package:hive/hive.dart';
import 'package:proyecto_pa/Modelo/Categoria.dart';

class HiveCategorias {
  final Box<Categoria> _categoriasBox;

  // Constructor para abrir la caja 'categorias'
  HiveCategorias() : _categoriasBox = Hive.box<Categoria>('categorias');

  // Agregar una nueva categoría usando el id como clave
  Future<bool> agregarCategoria(Categoria categoria) async {
    String idClave = categoria.id.toString().padLeft(2, '0'); // Convertir id a formato '01', '02', etc.
    if (_categoriasBox.containsKey(idClave)) {
      print('Error: Ya existe una categoría con ese ID.');
      return false;
    }
    await _categoriasBox.put(idClave, categoria); // Usar el id formateado como clave
    return true;
  }

  // Método para actualizar una categoría, manejando cambio de ID
  Future<bool> actualizarCategoria(Categoria categoriaAnterior, Categoria categoriaActualizada) async {
    String idClaveAnterior = categoriaAnterior.id.toString().padLeft(2, '0');
    String idClaveActualizado = categoriaActualizada.id.toString().padLeft(2, '0');

    // Si el ID no ha cambiado, simplemente actualiza la categoría
    if (idClaveAnterior == idClaveActualizado) {
      await _categoriasBox.put(idClaveAnterior, categoriaActualizada);
      return true;
    }

    // Si el ID ha cambiado, verifica que no haya conflicto con otra categoría
    if (_categoriasBox.containsKey(idClaveActualizado)) {
      print('Error: Ya existe una categoría con el nuevo ID.');
      return false;
    }

    // Si no hay conflicto, elimina la categoría anterior y agrega la nueva con el ID actualizado
    await _categoriasBox.delete(idClaveAnterior);
    await _categoriasBox.put(idClaveActualizado, categoriaActualizada);
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

  // Buscar una categoría por ID
  Categoria? buscarCategoria(int id) {
    String idClave = id.toString().padLeft(2, '0');
    return _categoriasBox.get(idClave);
  }

  // Obtener todas las categorías, ordenadas por ID
  Future<List<Categoria>> obtenerTodasCategorias() async {
    List<Categoria> categorias = _categoriasBox.values.toList();

    // Ordenar las categorías por ID
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
