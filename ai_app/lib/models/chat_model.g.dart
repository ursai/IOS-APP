// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatModelAdapter extends TypeAdapter<ChatModel> {
  @override
  final int typeId = 0;

  @override
  ChatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatModel(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[4] as String,
      fields[3] as int,
      fields[5] as int,
      fields[6] as String,
      fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.accountId)
      ..writeByte(1)
      ..write(obj.characterId)
      ..writeByte(2)
      ..write(obj.portraitUrl)
      ..writeByte(3)
      ..write(obj.msgTime)
      ..writeByte(4)
      ..write(obj.msgContent)
      ..writeByte(5)
      ..write(obj.isSend)
      ..writeByte(6)
      ..write(obj.characterName)
      ..writeByte(7)
      ..write(obj.msgType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
