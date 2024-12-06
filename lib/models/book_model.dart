class BookModel {
  final int id;
  final String title;
  final String? coverImage;
  final String author;

  BookModel({
    required this.id,
    required this.title,
    this.coverImage,
    required this.author,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      coverImage: json['formats']['image/jpeg'],
      author: json['authors'].isNotEmpty ? json['authors'][0]['name'] : 'Unknown Author',
    );
  }
}
