import 'dart:convert';

import 'package:formulaire_exemple/model/model_user.dart';
import 'package:http/http.dart' as http;

Future<int> registerUser(
  String firstName,
  String lastName,
  String email,
  String password,
) async {
  const String token = 'hykz0_pkv\$14!';

  const String url = "https://s3-5195.nuage-peda.fr/users";
  final headers = {'Content-Type': 'application/json', 'Authorization' : 'Bearer $token'};
  final body = jsonEncode({
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
  });

  try {
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      throw Exception(
          'The call to API failed here is the status code= ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('The call to API received an exception = $e');
  }
}

Future<http.Response> login(String email, String password) async {
  final url = Uri.parse('https://s3-5195.nuage-peda.fr/users/login');
  final headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    'email': email,
    'password': password,
  });
  final response = await http.post(
    url,
    headers: headers,
    body: body,
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to login: ${response.reasonPhrase}');
  }
}

Future<List<UserModel>> fetchUsers() async {
  const String url = "https://s3-5195.nuage-peda.fr/users";
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    List<dynamic> body = json.decode(response.body);
    List<UserModel> users = body.map((e) => UserModel.fromJson(e)).toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}
