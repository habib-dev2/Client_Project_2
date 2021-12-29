class Category {
  int? id;
  String? icon;
  String? name;

  toJson() {
    return {
      'id': id.toString(),
      'categoryName': name.toString(),
      'categoryIcon': icon.toString()
    };
  }
}
