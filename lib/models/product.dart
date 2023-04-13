class Product {
  final int id;
  final String title;
  final String? description;
  final double? rating;
  final String? brand;
  final String? category;
  final int price;
  final String thumbnailUrl;
  final List<dynamic>? images;
  final int stock;
  final String discountPercentage;

  Product(
      {required this.id,
      required this.title,
      this.description,
      this.rating,
      this.brand,
      this.category,
      required this.price,
      required this.thumbnailUrl,
      this.images,
      required this.stock,
      required this.discountPercentage});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      rating: json['rating'],
      brand: json['brand'],
      category: json['category'],
      price: json['price'],
      thumbnailUrl: json['thumbnail'],
      images: json['images'],
      stock: json['stock'],
      discountPercentage: json['discountPercentage'].toString());
}
