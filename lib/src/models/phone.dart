import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:untitled/src/models/review.dart';
import 'package:untitled/src/models/statistical.dart';

class Phone extends Equatable {
  String? id;
  String? name;
  String? brand;
  String? promotionprice;
  String? price;
  String? datePreproc;
  String? link;
  String? linkImage;
  List<Review>? review;
  Statistical? statistical;
  String? parameters;
  bool selected;
  Phone(
      {this.id,
      this.name,
      this.brand,
      this.promotionprice,
      this.price,
      this.datePreproc,
      this.link,
      this.linkImage,
      this.review,
      this.statistical,
      this.parameters,
      this.selected = false});

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.id,
        this.name,
        this.brand,
        this.promotionprice,
        this.price,
        this.datePreproc,
        this.link,
        this.linkImage,
        this.review,
        this.statistical,
        this.parameters,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'promotionprice': promotionprice,
      'Price': price,
      'datePreproc': datePreproc,
      'link': link,
      'linkImage': linkImage,
      'review': review?.map((x) => x.toMap()).toList(),
      'statistical': statistical?.toMap(),
      'parameters': parameters,
    };
  }

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
        id: map['id'],
        name: map['name'],
        brand: map['brand'],
        promotionprice: map['promotionprice'],
        price: map['brice'],
        datePreproc: map['datePreproc'],
        link: map['link'],
        linkImage: map['link_Image'] ?? "",
        review: map['review'] != null
            ? List<Review>.from(map['review'].map((x) => Review.fromMap(x)))
            : null,
        statistical: map['statistical'] != null
            ? Statistical.fromMap(map['statistical'])
            : null,
        parameters: map['parameters']
        //  map['parameters'] != null
        //     ? Parameters.fromMap(map['parameters'])
        //     : null,
        );
  }

  String toJson() => json.encode(toMap());

  factory Phone.fromJson(String source) => Phone.fromMap(json.decode(source));
}
