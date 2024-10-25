import 'package:hive/hive.dart';
import 'package:proyecto_pa/Modelo/Producto.dart';

class HiveProductos {
  final Box<Producto> _productosBox;

  // Constructor para abrir la caja 'productos'
  HiveProductos() : _productosBox = Hive.box<Producto>('productos');

  // Validar que el ID sea de la forma "001", "002", etc.
  String _formatearId(String id) {
    return id.padLeft(3, '0'); // Asegurarse de que tenga 3 caracteres
  }

  // Agregar un nuevo producto usando el id como clave
  Future<bool> agregarProducto(Producto producto) async {
    String idClave = _formatearId(producto.id); // Asegurarse de que el ID esté en el formato correcto
    if (_productosBox.containsKey(idClave)) {
      print('Error: Ya existe un producto con ese ID.');
      return false;
    }
    await _productosBox.put(idClave, producto); // Usar el id formateado como clave
    return true;
  }

  // Método para actualizar un producto, manejando cambio de ID
  Future<bool> actualizarProducto(Producto productoAnterior, Producto productoActualizado) async {
    String idClaveAnterior = _formatearId(productoAnterior.id);
    String idClaveActualizado = _formatearId(productoActualizado.id);

    // Si el ID no ha cambiado, simplemente actualiza el producto
    if (idClaveAnterior == idClaveActualizado) {
      await _productosBox.put(idClaveAnterior, productoActualizado);
      return true;
    }

    // Si el ID ha cambiado, verifica que no haya conflicto con otro producto
    if (_productosBox.containsKey(idClaveActualizado)) {
      print('Error: Ya existe un producto con el nuevo ID.');
      return false;
    }

    // Si no hay conflicto, elimina el producto anterior y agrega el nuevo con el ID actualizado
    await _productosBox.delete(idClaveAnterior);
    await _productosBox.put(idClaveActualizado, productoActualizado);
    return true;
  }

  // Eliminar un producto por ID
  Future<void> eliminarProducto(String id) async {
    String idClave = _formatearId(id); // Asegurarse de que el ID esté en el formato correcto
    await _productosBox.delete(idClave);
  }

  // Eliminar todos los productos
  Future<void> eliminarTodosProductos() async {
    await _productosBox.clear(); // Elimina todos los registros de la caja
  }

  // Buscar un producto por ID
  Producto? buscarProducto(String id) {
    String idClave = _formatearId(id); // Asegurarse de que el ID esté en el formato correcto
    return _productosBox.get(idClave);
  }

  // Obtener todos los productos, ordenados por ID
  Future<List<Producto>> obtenerTodosProductos() async {
    List<Producto> productos = _productosBox.values.toList();

    // Ordenar los productos por ID (debe ser por String para asegurar el orden correcto)
    productos.sort((a, b) => a.id.compareTo(b.id));
    return productos;
  }

  // Mostrar todos los productos en consola
  Future<void> mostrarProductos() async {
    List<Producto> productos = await obtenerTodosProductos();
    for (var producto in productos) {
      print(producto.toString());
    }
  }
}
