/// Category model representing a birthday wish category
class Category {
  final String id;
  final String name;
  final String emoji;
  final String color;

  Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'color': color,
    };
  }
}
