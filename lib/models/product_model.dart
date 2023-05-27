class ProductModel {
  int? id;
  String? code;
  String? name;
  int? quantity;
  DateTime? createdAt;

  ProductModel({
    this.id,
    this.code,
    this.name,
    this.quantity,
    this.createdAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    quantity = json['quantity'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'quantity': quantity,
      'created_at': createdAt,
    };
  }
}
