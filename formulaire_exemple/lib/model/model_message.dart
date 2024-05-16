class MessageModel {
  final int id;
  final String subject;
  final String body;
  final int userId;
  final int? replyToMessageId;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.id,
    required this.subject,
    required this.body,
    required this.userId,
    this.replyToMessageId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      subject: json['subject'],
      body: json['body'],
      userId: json['userId'],
      replyToMessageId: json['replyToMessageId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
