// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Producto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductoAdapter extends TypeAdapter<Producto> {
  @override
  final int typeId = 2;

  @override
  Producto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Producto(
      id: fields[0] as String,
      nombre: fields[1] as String?,
      categoria: fields[2] as String?,
      cantidad: fields[3] as int?,
      precioC: fields[4] as int?,
      precioV: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Producto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.categoria)
      ..writeByte(3)
      ..write(obj.cantidad)
      ..writeByte(4)
      ..write(obj.precioC)
      ..writeByte(5)
      ..write(obj.precioV);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
