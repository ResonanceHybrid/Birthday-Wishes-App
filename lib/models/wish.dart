/// Wish model representing a birthday wish
class Wish {
  final String id;
  final String categoryId;
  final String text;
  final String? imagePath;

  Wish({
    required this.id,
    required this.categoryId,
    required this.text,
    this.imagePath,
  });

  factory Wish.fromJson(Map<String, dynamic> json) {
    return Wish(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      text: json['text'] as String,
      imagePath: json['imagePath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'text': text,
      'imagePath': imagePath,
    };
  }

  Wish copyWith({
    String? id,
    String? categoryId,
    String? text,
    String? imagePath,
  }) {
    return Wish(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      text: text ?? this.text,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
