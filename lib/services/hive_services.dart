import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../model/user_model.dart';
import '../model/user_model_adaptor.dart';

class HiveServices {
  static Future<void>  initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter<UserModel>(UserModelAdapter());
  }

  static Future<List<UserModel>> getUserBox(String boxName) async {
    await Hive.openBox(boxName);
    final box = Hive.box(boxName);
    return box.values
        .toList(growable: false)
        .cast<UserModel>()
        .reversed
        .toList();
  }

  static storeDataList(String boxName, List<UserModel> userModel) async {
    await Hive.openBox(boxName);
    final box = Hive.box(boxName);
    if (box.isEmpty) {
      await box.addAll(userModel.reversed);
    } else {
      return;
    }
  }

  static addData(String boxName, UserModel userModel) async {
    final box = Hive.box(boxName);
    //  await Hive.openBox(boxName);
    await box.add(userModel);
  }

  static deleteAllData(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      await box.clear();
    } else {
      final b = await Hive.openBox(boxName);
      b.clear();
    }
  }

  static deleteData(String boxName, int index) async {
    final box = Hive.box(boxName);
    //  await Hive.openBox(boxName);
    final itemCount = box.length;
    if (index >= 0 && index <= itemCount) {
      int rvIndex = itemCount - index - 1;
      await box.deleteAt(rvIndex);
    }
  }
}
