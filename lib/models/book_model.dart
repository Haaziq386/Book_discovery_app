class BookModel {
  final int id;
  final String title;
  final String? coverImage;
  final String author;
  final List<String> subjects;
  final int downloadCount;
  final List<String> bookshelves;
  final Map<String, String> formats;

  BookModel({
    required this.id,
    required this.title,
    this.coverImage,
    required this.author,
    required this.subjects,
    required this.downloadCount,
    required this.bookshelves,
    required this.formats,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      coverImage: json['formats']['image/jpeg'],
      author: json['authors'].isNotEmpty
          ? json['authors'][0]['name']
          : 'Unknown Author',
      subjects: List<String>.from(json['subjects']),
      downloadCount: json['download_count'],
      bookshelves: List<String>.from(json['bookshelves']),
      formats: (json['formats'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toString())),
    );
  }
}
