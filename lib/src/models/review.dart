import 'dart:convert';

class Review {
  String? comment;
  int? id;
  String? label;

  Review({
    this.comment,
    this.id,
    this.label,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'id': id,
      'label': label,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      comment: map['comment'],
      id: map['id']?.toInt(),
      label: map['label'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}
