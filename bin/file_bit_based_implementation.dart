import 'dart:convert';
import 'dart:io';
import 'implementation_interface.dart';
import 'user_details_model.dart';

class UserDetailsBitRepository implements IRepository<UserDetails> {
  final String basePath =
      "${Directory.current.path}${Platform.pathSeparator}fileStorage";
  final String fileName = "fileStorage.bits";

  Future<File> _getFile() async {
    final dir = Directory(basePath);
    if (!(await dir.exists())) await dir.create(recursive: true);

    final file = File("$basePath${Platform.pathSeparator}$fileName");
    if (!(await file.exists())) {
      await file.create(recursive: true);
      await file.writeAsString(_encodeJson([])); // initialize empty list
    }
    return file;
  }

  String _bytesToBits(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(2).padLeft(8, '0')).join();

  List<int> _bitsToBytes(String bits) {
    bits = bits.replaceAll(RegExp(r'\s+'), ''); // remove spaces/newlines
    if (bits.isEmpty) return [];
    if (bits.length % 8 != 0) {
      throw FormatException("Bit string length must be a multiple of 8");
    }
    return [
      for (var i = 0; i < bits.length; i += 8)
        int.parse(bits.substring(i, i + 8), radix: 2)
    ];
  }

  String _encodeJson(List<dynamic> data) =>
      _bytesToBits(utf8.encode(jsonEncode(data)));

  Future<List<dynamic>> _readJson() async {
    final file = await _getFile();
    final bits = (await file.readAsString()).trim();
    if (bits.isEmpty) return [];
    return jsonDecode(utf8.decode(_bitsToBytes(bits)));
  }

  Future<void> _writeJson(List<dynamic> data) async {
    final file = await _getFile();
    await file.writeAsString(_encodeJson(data), flush: true);
  }

  String? _id(UserDetails u) => u.data?.userId;


  @override
  Future<void> create(UserDetails user) async {
    final list = await _readJson();
    if (_id(user) == null || _id(user)!.isEmpty) {
      print("Cannot create: userId is null/empty");
      return;
    }
    if (list.any((e) => _id(UserDetails.fromJson(e)) == _id(user))) {
      print("UserId ${_id(user)} already exists");
      return;
    }
    list.add(user.toJson());
    await _writeJson(list);
    print("Created user: ${_id(user)}");
  }

  @override
  Future<List<UserDetails>> list() async {
    final list = await _readJson();
    final users = list.map((e) => UserDetails.fromJson(e)).toList();
    print("Loaded ${users.length} users.");
    return users;
  }

  @override
  Future<UserDetails?> findById(String id) async {
    for (final e in await _readJson()) {
      final user = UserDetails.fromJson(e);
      if (_id(user) == id) return user;
    }
    print("User with ID=$id not found.");
    return null;
  }

  @override
  Future<void> update(String id, UserDetails updated) async {
    final list = await _readJson();
    for (var i = 0; i < list.length; i++) {
      if (_id(UserDetails.fromJson(list[i])) == id) {
        list[i] = updated.toJson();
        await _writeJson(list);
        print("Updated user: $id");
        return;
      }
    }
    print("User with ID=$id not found.");
  }

  @override
  Future<void> delete(String id) async {
    final list = await _readJson();
    final newList = list.where((e) => _id(UserDetails.fromJson(e)) != id).toList();
    if (newList.length == list.length) {
      print("User with ID=$id not found.");
      return;
    }
    await _writeJson(newList);
    print("Deleted user: $id");
  }

  @override
  Future<void> deleteAll() async {
    await _writeJson([]);
    print("All users deleted.");
  }
}
