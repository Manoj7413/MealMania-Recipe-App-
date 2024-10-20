class mymodel {
  String? image;
  String? name;
  List<String>? ingredient; // Change type to List<String> to match the data
  int? calories;
  String? url;

  mymodel({this.image, this.name, this.ingredient, this.calories, this.url});

  // Factory constructor to create an instance from a map
  factory mymodel.fromMap(Map<String, dynamic> map) {
    return mymodel(
      image: map['image'] ?? '',
      name: map['label'] as String?,
      ingredient: List<String>.from(map['ingredientLines'] ?? []), // Convert to List<String>
      calories: (map['calories'] as num?)?.toInt(),
      url: map['url'] as String?,
    );
  }
}
