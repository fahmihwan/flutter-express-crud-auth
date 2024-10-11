class Book {
  final int id;
  // final int statusenabled;
  final bool statusenabled;
  final String title;
  final String createdAt;

  Book(
      {required this.id,
      required this.statusenabled,
      required this.title,
      required this.createdAt});

  // Factory constructor untuk membuat instance dari JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        statusenabled: json['statusenabled'],
        title: json['title'],
        createdAt: json['created_at']);
  }

  @override
  String toString() {
    return 'Book(title: $title, statusenabled: $statusenabled, createdAt: $createdAt)';
  }
}
