// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Categoria.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriaAdapter extends TypeAdapter<Categoria> {
  @override
  final int typeId = 1;

  @override
  Categoria read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categoria(
      id: fields[0] as int,
      nombre: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Categoria obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
