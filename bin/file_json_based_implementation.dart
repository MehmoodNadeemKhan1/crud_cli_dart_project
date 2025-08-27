import 'dart:convert';
import 'dart:io';
import 'implementation_interface.dart';
import 'user_details_model.dart';

class userdetails_File_Json_Based_Implementation implements IRepository<UserDetails>
{
    @override
    Future<void> create(UserDetails item) async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final directory = Directory(basePath);

        if (!(await directory.exists())) 
        {
            await directory.create(recursive: true);
            print("Created directory: $basePath");
        }

        final filePath = "$basePath${Platform.pathSeparator}fileStorage.json";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            await file.create(recursive: true);
            await file.writeAsString(jsonEncode([]));
            print("Created file: $filePath");
        }

        final content = await file.readAsString();
        final List<dynamic> jsonList = content.isNotEmpty ? jsonDecode(content) : [];

        jsonList.add(item.toJson());

        await file.writeAsString(jsonEncode(jsonList));

        print("Data successfully created: ${item.data?.userId}");
    }

    @override
    Future<void> deleteAll() async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.json";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
            return;
        }
        await file.writeAsString(jsonEncode([]));
        print("All users deleted successfully.");
    }

    @override
    Future<UserDetails?> findById(String id) async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.json";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
            return null;
        }

        final content = await file.readAsString();
        if (content.trim().isEmpty) 
        {
            print("File is empty.");
            return null;
        }

        final List<dynamic> jsonList = jsonDecode(content);
        final users = jsonList.map((json) => UserDetails.fromJson(json)).toList();

        final user = users.firstWhere(
            (u) => u.data?.userId == id
        );

        if (user.data?.userId == null) 
        {
            print("User with ID=$id not found.");
            return null;
        }

        print("Found user: ${user.toJson()}");
        return user;
    }

    @override
    Future<List<UserDetails>>? list() async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.json";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
            return [];
        }

        final content = await file.readAsString();
        if (content.trim().isEmpty) 
        {
            print("File is empty.");
            return [];

        }
        final List<dynamic> jsonList = jsonDecode(content);
        final users = jsonList.map((json) => UserDetails.fromJson(json)).toList();

        return users;

    }

    @override
    Future<void> update(String id, UserDetails updatedItem) async {
      final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
      final filePath = "$basePath${Platform.pathSeparator}fileStorage.json";
      final file = File(filePath);

      if (!(await file.exists())) {
        print("File does not exist: $filePath");
        return;
      }

      final content = await file.readAsString();
      if (content.trim().isEmpty) {
        print("File is empty.");
        return;
      }

      final List<dynamic> jsonList = jsonDecode(content);
      final users = jsonList.map((json) => UserDetails.fromJson(json)).toList();

      final index = users.indexWhere((user) => user.data?.userId == id);

      if (index == -1) {
        print("User with ID=$id not found.");
        return;
      }

      users[index] = updatedItem;

      final updatedJsonList = users.map((user) => user.toJson()).toList();
      await file.writeAsString(jsonEncode(updatedJsonList));

      print("User with ID=$id updated successfully.");
    }


    @override
    Future<void> delete(String id) async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.json";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
            return;
        }

        final content = await file.readAsString();
        if (content.trim().isEmpty) 
        {
            print("File is empty.");
            return;
        }

        final List<dynamic> jsonList = jsonDecode(content);

        final users = jsonList.map((json) => UserDetails.fromJson(json)).toList();

        final updatedUsers =
            users.where((user) => user.data?.userId != id).toList();

        if (updatedUsers.length == users.length) 
        {
            print("User with ID=$id not found.");
            return;
        }

        final jsonString = jsonEncode(updatedUsers.map((u) => (u as UserDetails).toJson()).toList());
        await file.writeAsString(jsonString);

        print("User with ID=$id deleted successfully.");
    }

}

