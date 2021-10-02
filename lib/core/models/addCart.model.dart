import 'dart:convert';

class AddCartModel {
  final String image;
  final String name;
  final String size;
  final String price;
  // final String userUid;
  final int cheeseValue;
  final int ketchupValue;
  final int onionValue;

  AddCartModel({
    required this.image,
    required this.name,
    required this.size,
    required this.price,
    required this.cheeseValue,
    required this.ketchupValue,
    required this.onionValue,
  });

  AddCartModel copyWith({
    String? image,
    String? name,
    String? size,
    String? price,
    int? cheeseValue,
    int? ketchupValue,
    int? onionValue,
  }) {
    return AddCartModel(
      image: image ?? this.image,
      name: name ?? this.name,
      size: size ?? this.size,
      price: price ?? this.price,
      cheeseValue: cheeseValue ?? this.cheeseValue,
      ketchupValue: ketchupValue ?? this.ketchupValue,
      onionValue: onionValue ?? this.onionValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'size': size,
      'price': price,
      'cheeseValue': cheeseValue,
      'ketchupValue': ketchupValue,
      'onionValue': onionValue,
    };
  }

  factory AddCartModel.fromMap(Map<String, dynamic> map) {
    return AddCartModel(
      image: map['image'],
      name: map['name'],
      size: map['size'],
      price: map['price'],
      cheeseValue: map['cheeseValue'],
      ketchupValue: map['ketchupValue'],
      onionValue: map['onionValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCartModel.fromJson(String source) =>
      AddCartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddCartModel(image: $image, name: $name, size: $size, price: $price, cheeseValue: $cheeseValue, ketchupValue: $ketchupValue, onionValue: $onionValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddCartModel &&
        other.image == image &&
        other.name == name &&
        other.size == size &&
        other.price == price &&
        other.cheeseValue == cheeseValue &&
        other.ketchupValue == ketchupValue &&
        other.onionValue == onionValue;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        name.hashCode ^
        size.hashCode ^
        price.hashCode ^
        cheeseValue.hashCode ^
        ketchupValue.hashCode ^
        onionValue.hashCode;
  }
}
