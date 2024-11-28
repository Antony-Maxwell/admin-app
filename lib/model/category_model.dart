class CategoryModel {
    String name;
    String id;
    String imageUrl;

    CategoryModel({
        required this.name,
        required this.id,
        required this.imageUrl,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        id: json["_id"],
        imageUrl: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": imageUrl,
    };
}