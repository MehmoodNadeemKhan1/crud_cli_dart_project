import 'dart:convert';
import 'package:http/http.dart'as http;
import 'implementation_interface.dart';
import 'user_details_model.dart';

class ApiClient {
  final String baseUrl;
  ApiClient({this.baseUrl = 'https://api.restful-api.dev'});

  Future<http.Response> post(String path, Map<String, dynamic> body) =>
      http.post(Uri.parse('$baseUrl$path'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));


  Future<http.Response> getAll(String path) =>
      http.get(Uri.parse('$baseUrl$path'),
          headers: {'Content-Type': 'application/json'});

  Future<http.Response> get(String id,String path) =>
      http.get(Uri.parse('$baseUrl$path/$id'),
          headers: {'Content-Type': 'application/json'});

  Future<http.Response> delete(String id,String path) =>
      http.delete(Uri.parse('$baseUrl$path/$id'),
          headers: {'Content-Type': 'application/json'});

  Future<http.Response> deleteAll(String path) =>
      http.delete(Uri.parse('$baseUrl$path'),
          headers: {'Content-Type': 'application/json'});


  Future<http.Response> patch(String id,String path, Map<String, dynamic> body) =>
      http.patch(Uri.parse('$baseUrl$path/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));

}







class UserDetailsApiRepository implements IRepository<UserDetails> {
  final ApiClient _client;
  UserDetailsApiRepository(this._client);

  @override
  Future<void> create(UserDetails item) async {
  final response = await _client.post("/objects", item.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Created: ${response.body}");
    } else {
      print("Failed: ${response.statusCode}");
    }
  }

  @override
  Future<void> delete(String id) async {
    final response = await _client.delete(id, "/objects");
    print("deleting users from API...");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("$id Successfully deleted");
    } else {
      print("Failed: ${response.statusCode}");
    }
  }

  @override
  Future<void> deleteAll() async{
    print("Delete");

  }

  @override
  Future<UserDetails?> findById(String id) async {
    final response = await _client.get(id, "/objects");
    print("Fetching users from API...");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsondata = jsonDecode(response.body);
     final userdetails = UserDetails.fromJson(jsondata);
     print("Fetched Result:$userdetails");
    } else {
      print("Failed: ${response.statusCode}");
    }

  }

  @override
  Future<List<UserDetails>> list() async {
    final response = await _client.getAll("/objects");
    print("Fetching users from API...");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);
      final users = data.map((e) => UserDetails.fromJson(e)).toList();
      print("Fetched Result: $users");
      return users;
    } else {
      print("Failed: ${response.statusCode}");
      return [];
    }
  }

  @override
  Future<void> update(String id, UserDetails updatedItem) async {
final response = await _client.patch(id, "/objects", updatedItem.toJson());
if (response.statusCode == 200 || response.statusCode == 201) {
  print("Updated: ${response.body}");
} else {
  print("Failed: ${response.statusCode}");
}

  }



}