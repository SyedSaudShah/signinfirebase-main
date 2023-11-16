import 'dart:convert';

class Cartitem {
  String img;
  String name;
  num price;
  int quantity;
  String productId;
  Cartitem({
    required this.img,
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.productId,
  });

  Cartitem copyWith({
    String? img,
    String? name,
    num? price,
    int? quantity,
  }) {
    return Cartitem(
      productId: productId,
      img: img ?? this.img,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'name': name,
      'price': price,
      'quantity': quantity,
      'productId': productId
    };
  }

  factory Cartitem.fromMap(Map<String, dynamic> map) {
    return Cartitem(
        img: map['img'],
        name: map['name'],
        price: map['price'],
        quantity: map['quantity'],
        productId: map['productId']);
  }

  String toJson() => json.encode(toMap());

  factory Cartitem.fromJson(String source) =>
      Cartitem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cartitem(img: $img, name: $name, price: $price, quantity: $quantity,productId: $productId )';
  }

  @override
  bool operator ==(covariant Cartitem other) {
    if (identical(this, other)) return true;

    return other.img == img &&
        other.name == name &&
        other.price == price &&
        other.quantity == quantity &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return img.hashCode ^ name.hashCode ^ price.hashCode ^ quantity.hashCode;
  }
}
