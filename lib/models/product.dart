class Product {
  final String name;
  final List<dynamic> images;
  final String description;
  final int price;
  final List<dynamic> sizes;
  final String id;

  Product(
      {required this.name,
      required this.images,
      required this.description,
      required this.price,
      required this.sizes,
      required this.id});
}
