class Product2 {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  Product2({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  // Factory method to parse from JSON (used for API call)
  factory Product2.fromJson(Map<String, dynamic> json) {
    return Product2(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
    );
  }
}

class topBarIconList {
  final String id;
  final String iconName;
  final String name;


  topBarIconList({
    required this.id,
    required this.iconName,
    required this.name,
  });

  // Factory method to parse from JSON (used for API call)
  factory topBarIconList.fromJson(Map<String, dynamic> json) {
    return topBarIconList(
      id: json['id'],
      name: json['name'],
      iconName: json['iconName'],
    );
  }
}

class BestSeller {
  final String id;
  final String name;
  final String description;
  final List<String> imageList;
  final double price;

  BestSeller({
    required this.id,
    required this.name,
    required this.description,
    required this.imageList,
    required this.price,
  });

  // Factory method to parse from JSON (used for API call)
  factory BestSeller.fromJson(Map<String, dynamic> json) {
    return BestSeller(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageList: json['imageUrl'],
      price: json['price'].toDouble(),
    );
  }
}