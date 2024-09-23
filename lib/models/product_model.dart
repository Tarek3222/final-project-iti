class ProductModel {
   String name;
   String description;
   String image;
   String price;
   String category;
   String quantity;
  final String? id;
  String? quantityInCart;

  ProductModel( 
      {required this.name,
      this.id,
      this.quantityInCart,
      required this.description,
      required this.image,
      required this.price,
      required this.category,
      required this.quantity});
}
