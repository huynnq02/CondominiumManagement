import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Feedback {
  final String id;
  final String feedback;
  final DateTime createdAt;
  final String image;
  final String type;
  final String title;
  final String status;
  final String respone;
  Feedback({
    required this.id,
    required this.feedback,
    required this.createdAt,
    required this.image,
    required this.type,
    required this.title,
    required this.status,
    required this.respone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'feedback': feedback,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'image': image,
      'type': type,
      'title': title,
      'status': status,
      'respone': respone,
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      id: map['id'] as String,
      feedback: map['feedback'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      image: map['image'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      status: map['status'] as String,
      respone: map['respone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source) as Map<String, dynamic>);
}
