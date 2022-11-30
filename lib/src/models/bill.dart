import 'dart:convert';
import 'dart:ffi';

class Bill {
  int? id;
  String name;
  String type;
  String deadline;
  String price;
  String state;
  Bill({
    this.id,
    required this.name,
    required this.type,
    required this.deadline,
    required this.price,
    required this.state,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'deadline': deadline,
      'price': price,
      'condition': state,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      deadline: map['deadline'],
      price: map['price'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);
}
