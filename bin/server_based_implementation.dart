import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'implementation_interface.dart';
import 'user_details_model.dart';

class ApiClient
{
    final String baseUrl;
    ApiClient({this.baseUrl = 'https://api.restful-api.dev'});

    Future<http.Response> post(String path, Map<String, dynamic> body) =>
    http.post(Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body));

    Future<http.Response> getAll(String path) =>
    http.get(Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'});

    Future<http.Response> get(String id, String path) =>
    http.get(Uri.parse('$baseUrl$path/$id'),
        headers: {'Content-Type': 'application/json'});

    Future<http.Response> delete(String id, String path) =>
    http.delete(Uri.parse('$baseUrl$path/$id'),
        headers: {'Content-Type': 'application/json'});

    Future<http.Response> deleteAll(String path) =>
    http.delete(Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'});

    Future<http.Response> patch(String id, String path, Map<String, dynamic> body) =>
    http.patch(Uri.parse('$baseUrl$path/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body));

}

class UserDetailsApiRepository implements IRepository<UserDetails>
{
    final ApiClient _client;
    UserDetailsApiRepository(this._client);

    @override
    Future<void> create(UserDetails item) async
    {
        final response = await _client.post("/objects", item.toJson());
        if (response.statusCode == 200 || response.statusCode == 201) 
        {
            final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
            final String id = jsonResponse['id'];
            print("Created ID: $id");
            final basepath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
            final directory = Directory(basepath);
            await directory.create(recursive: true);
            final file = File("$basepath/serverfile.txt");
            if (!(await file.exists()))
            {
              await file.create(recursive: true);
              print("File Created");

              final header = '''
|-------------------------------------------------------------------------------------------------------------------------|
|                                                           'ID'                                                          |
|-------------------------------------------------------------------------------------------------------------------------|
''';
              await file.writeAsString(header, mode: FileMode.append);
            }
            else
            {
              print("File already exists");
            }

            final row =
                "${("| $id").padLeft(80)} |\n";
            await file.writeAsString(row, mode: FileMode.append);
            print("Data Sucessfully created");

            print("Created: ${response.body}");
        }
        else 
        {
            print("Failed: ${response.statusCode}");
        }
    }

    @override
    Future<void> delete(String id) async
    {
        final response = await _client.delete(id, "/objects");
        print("deleting users from API...");
        if (response.statusCode == 200 || response.statusCode == 201) 
        {
            print("$id Successfully deleted");
        }
        else 
        {
            print("Failed: ${response.statusCode}");
        }
    }

    Future<List<String>> listOfIds() async {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}serverfile.txt";
        final file = File(filePath);

        if (!(await file.exists())) {
            print("File does not exist: $filePath");
            return [];
        }

        final lines = await file.readAsLines();
        if (lines.length <= 3) {
            print("You must have create data before deletion");
            return [];
        }

        final dataLines = lines.skip(3).where((line) => line.trim().isNotEmpty);

        final ids = dataLines.map((line) {
            final cols = line
                .split("|")
                .map((c) => c.trim())
                .where((c) => c.isNotEmpty)
                .toList();

            return cols.isNotEmpty ? cols[0] : ""; // assuming first column is ID
        }).where((id) => id.isNotEmpty).toList();

        return ids;
    }

    @override
    Future<void> deleteAll() async {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}serverfile.txt";
        final file = File(filePath);
       final ids =  await listOfIds();
       for(int i=0 ; i<ids.length;i++){
           final response = await _client.delete(ids[i], "/objects");
           print("deleting users from API...");
           if (response.statusCode == 200 || response.statusCode == 201)
           {
               print("$i Successfully deleted");

           }
           else
           {
               print("Failed: ${response.statusCode}");
           }

       }
       final lines = await file.readAsLines();
       final headerLines = lines.take(3).toList();
       await file.writeAsString(headerLines.join('\n') + '\n');
       print("All data rows deleted successfully");
    }


    @override
    Future<UserDetails?> findById(String id) async
    {
        final response = await _client.get(id, "/objects");
        print("Fetching users from API...");
        if (response.statusCode == 200 || response.statusCode == 201) 
        {
            final Map<String, dynamic> jsondata = jsonDecode(response.body);
            final userdetails = UserDetails.fromJson(jsondata);
            print("Fetched Result:$userdetails");
        }
        else 
        {
            print("failed not found: ${response.statusCode}");
        }
    }

    @override
    Future<List<UserDetails>> list() async {
        final ids = await listOfIds();
        final List<UserDetails> users = [];

        for (int i = 0; i < ids.length; i++) {
            final response = await _client.get(ids[i], "/objects");
            print("Fetching user with ID: ${ids[i]}...");

            if (response.statusCode == 200 || response.statusCode == 201) {
                final Map<String, dynamic> jsondata = jsonDecode(response.body);
                final userdetails = UserDetails.fromJson(jsondata);
                users.add(userdetails);
                print("Fetched Result: $userdetails");
            } else {
                print("Failed to fetch ID ${ids[i]}: ${response.statusCode}");
            }
        }

        return users;
    }

    @override
    Future<void> update(String id, UserDetails updatedItem) async
    {
        final response = await _client.patch(id, "/objects", updatedItem.toJson());
        if (response.statusCode == 200 || response.statusCode == 201) 
        {
            print("Updated: ${response.body}");
        }
        else 
        {
            print("Failed: ${response.statusCode}");
        }

    }

}
