import 'package:firebase_auth_log_in/model/user_model.dart';
import 'package:hive_flutter/adapters.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    final Map<dynamic, dynamic> fields = {};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }
    return UserModel(
      userId: fields[0] as int?,
      id: fields[1] as int?,
      title: fields[2] as String,
      body: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeByte(4); // Number of fields in the model
    writer.writeByte(0);
    writer.write(obj.userId);
    writer.writeByte(1);
    writer.write(obj.id);
    writer.writeByte(2);
    writer.write(obj.title);
    writer.writeByte(3);
    writer.write(obj.body);
  }
}
