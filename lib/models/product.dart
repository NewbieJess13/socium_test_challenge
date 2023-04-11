class Product {
  final int id;
  final String title;
  final double price;
  final String thumbnailUrl;
  final int stock;
  final double discountPercentage;

  Product(this.id, this.title, this.price, this.thumbnailUrl, this.stock,
      this.discountPercentage);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      json['id'],
      json['title'],
      json['price'],
      json['thumbnail'],
      json['stock'],
      json['discountPercentage']);
}
