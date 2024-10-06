class SearchRecipe {
  int id;
  String title;
  String image;

 SearchRecipe({required this.id, required this.title, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory SearchRecipe.fromMap(Map<String, dynamic> map) {
    return SearchRecipe(
      id: map['id'],
     title: map['title'],
      image: map['image'],
    );
  }
}

class RecipeInfo {
  int id;
  String title;
  String image;
  String sourceUrl;
  String summary;

  RecipeInfo({required this.id, required this.title, required this.image, required this.sourceUrl, required this.summary});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'sourceUrl': sourceUrl,
      'summary': summary
    };
  }

  factory RecipeInfo.fromMap(Map<String, dynamic> map) {
    return RecipeInfo(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      sourceUrl: map['sourceUrl'],
      summary: map['summary']
    );
  }

}