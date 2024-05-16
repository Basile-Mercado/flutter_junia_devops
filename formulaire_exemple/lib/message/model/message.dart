import 'package:formulaire_exemple/user/model/user.dart';

class Message {
  final String title;
  final User user;
  final String content;
  final DateTime publishDate;

  const Message(
      {required this.title,
      required this.user,
      required this.content,
      required this.publishDate});

  Message copyWith({
    required String title,
    required String content,
    required User user,
    required DateTime publishDate,
  }) {
    return Message(
      title: title,
      user: user,
      content: content,
      publishDate: publishDate,
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'Message= $title, $content';
  }
}
