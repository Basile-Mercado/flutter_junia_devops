import 'dart:convert';
import 'package:formulaire_exemple/model/model_message.dart';
import 'package:http/http.dart' as http;

class Message {
  static const String apiUrl = 'https://s3-5195.nuage-peda.fr/messages';

  Future<List<MessageModel>> fetchMessages() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<MessageModel> messages =
          body.map((dynamic item) => MessageModel.fromJson(item)).toList();
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
