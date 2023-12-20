abstract class ILocalStorageService {
  Future<dynamic> read(
      {required String boxName, required String key, dynamic defaultValue});
  Future<void> write(
      {required String boxName, required String key, required dynamic value});
  Future<void> delete({required String boxName, required String key});
  Future<void> deleteAll();
}
