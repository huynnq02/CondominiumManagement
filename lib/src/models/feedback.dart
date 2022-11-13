import 'dart:convert';

class Feedback {
  int? id;
  String email;
  String type;
  String time;
  String title;
  String status;
  String content;
  String? respond;
  String? image;
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
      id: map['id'],
      email: map['email'] as String,
      content: map['content'] as String,
      time: map['time'],
      image: map['image']?.toString(),
      type: map['type'] as String,
      title: map['title'] as String,
      status: map['status'],
      respond: map['respond']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source) as Map<String, dynamic>);
}
