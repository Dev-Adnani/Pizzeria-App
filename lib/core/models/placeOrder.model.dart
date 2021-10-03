import 'dart:convert';

class OrderModel {
  final String userName;
  final String image;
  final String pizza;
  final String time;
  final String location;
  final String size;
  final int cheeseValue;
  final int ketchupValue;
  final int onionValue;

  OrderModel({
    required this.userName,
    required this.image,
    required this.pizza,
    required this.time,
    required this.location,
    required this.size,
    required this.cheeseValue,
    required this.ketchupValue,
    required this.onionValue,
  });

  OrderModel copyWith({
    String? userName,
    String? image,
    String? pizza,
    String? time,
    String? location,
    String? size,
    int? cheeseValue,
    int? ketchupValue,
    int? onionValue,
  }) {
    return OrderModel(
      userName: userName ?? this.userName,
      image: image ?? this.image,
      pizza: pizza ?? this.pizza,
      time: time ?? this.time,
      location: location ?? this.location,
      size: size ?? this.size,
      cheeseValue: cheeseValue ?? this.cheeseValue,
      ketchupValue: ketchupValue ?? this.ketchupValue,
      onionValue: onionValue ?? this.onionValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'image': image,
      'pizza': pizza,
      'time': time,
      'location': location,
      'size': size,
      'cheeseValue': cheeseValue,
      'ketchupValue': ketchupValue,
      'onionValue': onionValue,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userName: map['userName'],
      image: map['image'],
      pizza: map['pizza'],
      time: map['time'],
      location: map['location'],
      size: map['size'],
      cheeseValue: map['cheeseValue'],
      ketchupValue: map['ketchupValue'],
      onionValue: map['onionValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(userName: $userName, image: $image, pizza: $pizza, time: $time, location: $location, size: $size, cheeseValue: $cheeseValue, ketchupValue: $ketchupValue, onionValue: $onionValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.userName == userName &&
        other.image == image &&
        other.pizza == pizza &&
        other.time == time &&
        other.location == location &&
        other.size == size &&
        other.cheeseValue == cheeseValue &&
        other.ketchupValue == ketchupValue &&
        other.onionValue == onionValue;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        image.hashCode ^
        pizza.hashCode ^
        time.hashCode ^
        location.hashCode ^
        size.hashCode ^
        cheeseValue.hashCode ^
        ketchupValue.hashCode ^
        onionValue.hashCode;
  }
}
