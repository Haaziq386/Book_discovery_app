import 'package:book_discovery_app/models/book_model.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            book.coverImage != null
                ? Image.network(book.coverImage!,
                    height: 200, fit: BoxFit.cover)
                : Icon(Icons.book, size: 100),
            SizedBox(height: 16),
            Text(
              'Title:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              book.title,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 8),
            Text(
              'Author:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('${book.author}', style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Text(
              'Subjects:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('${book.subjects.join(",")}'),
            SizedBox(height: 8),
            Text(
              'Download Count:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('${book.downloadCount}'),
          ],
        ),
      ),
    );
  }
}
