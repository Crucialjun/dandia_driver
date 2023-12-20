import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import 'i_local_storage_service.dart';

class LocalStorageService extends ILocalStorageService {
  @override
  Future<void> delete({required String boxName, required String key}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() async {
    await Hive.deleteFromDisk();
  }

  @override
  Future read(
      {required String boxName,
      required String key,
      dynamic defaultValue}) async {
    try {
      var box = await Hive.openBox(boxName);
      return box.get(key, defaultValue: defaultValue);
    } on Exception catch (e) {
      Logger().e(e);
      return defaultValue;
    }
  }

  @override
  Future<void> write(
      {required String boxName, required String key, value}) async {
    var box = await Hive.openBox(boxName);
    return box.put(key, value);
  }
}
