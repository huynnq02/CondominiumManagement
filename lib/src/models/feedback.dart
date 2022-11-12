import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Feedback {
  final String? id;
  final String email;
  final String type;
  final String time;
  final String title;
  final String status;
  final String content;
  final String? respond;
  final String? image;
  Feedback({
    this.id,
    required this.email,
    required this.type,
    required this.time,
    required this.title,
    required this.status,
    required this.content,
    this.respond,
    this.image,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'time': time,
      'email': email,
      'image': image,
      'type': type,
      'title': title,
      'status': status,
      'respond': respond,
      'content': content,
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      id: map['id'] as String,
      email: map['email'] as String,
      content: map['content'] as String,
      time: map['time'],
      image: map['image']?.toString(),
      type: map['type'] as String,
      title: map['title'] as String,
      status: map['status'] as String,
      respond: map['respond'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source) as Map<String, dynamic>);
}
