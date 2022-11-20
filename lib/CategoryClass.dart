

class CategoryClass {
  final String title;
  final String image;

  CategoryClass({
    required this.title,
    required this.image,
  });

  factory CategoryClass.fromMap(Map<String, dynamic> map) {
    return CategoryClass(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
    );
  }
}

List<CategoryClass> category = [
  CategoryClass(title: "Arte", image: 'assets/category/arte.jpg'),
  CategoryClass(title: "Cinema", image: 'assets/category/cinema.jpg'),
  CategoryClass(title: "Geografia", image: 'assets/category/mondo.jpg'),
  CategoryClass(title: "Sport", image: 'assets/category/arte.jpg'),
  CategoryClass(title: "Storia", image: 'assets/category/arte.jpg'),
  CategoryClass(title: "Tech", image: 'assets/category/arte.jpg'),
];