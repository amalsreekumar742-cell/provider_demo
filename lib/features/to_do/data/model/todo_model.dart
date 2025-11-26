import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String? id;
  final String? title;
  final Timestamp? createdAt;
  final String? des;
  final num? price;

  TodoModel({
    this.id,
    this.title,
    this.createdAt,
    this.des,
    this.price,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    Timestamp? createdAt,
    String? des,
    num? price,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      des: des ?? this.des,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'des': des ?? '',
      'price': price,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id']?.toString(),                      
      title: map['title']?.toString() ?? "",          
      createdAt: map['createdAt'] as Timestamp?,       
      des: map['des']?.toString() ?? "",               
      price: map['price'] is num ? map['price'] : 0,   
    );
  }
}
