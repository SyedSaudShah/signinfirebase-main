// ignore: file_names
// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, duplicate_ignore
import 'dart:convert';

class GetImage {
  String img;
  String name;
  num price;
  String id;
  GetImage({
    required this.img,
    required this.name,
    required this.price,
    required this.id,
  });

  GetImage copyWith({
    String? img,
    String? name,
    num? price,
    String? id,
  }) {
    return GetImage(
      img: img ?? this.img,
      name: name ?? this.name,
      price: price ?? this.price,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'name': name,
      'price': price,
      'id': id,
    };
  }

  factory GetImage.fromMap(Map<String, dynamic> map) {
    return GetImage(
      img: map['img'] as String,
      name: map['name'] as String,
      price: map['price'] as num,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetImage.fromJson(String source) =>
      GetImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetImage(img: $img, name: $name, price: $price, id: $id)';
  }

  @override
  bool operator ==(covariant GetImage other) {
    if (identical(this, other)) return true;

    return other.img == img &&
        other.name == name &&
        other.price == price &&
        other.id == id;
  }

  @override
  int get hashCode {
    return img.hashCode ^ name.hashCode ^ price.hashCode ^ id.hashCode;
  }
}
