import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book['formats']['image/jpeg'] != null)
              Center(
                child: Image.network(
                  book['formats']['image/jpeg'],
                  width: 150,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Title:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(book['title'], style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(
              'Author:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              book['authors'].isNotEmpty
                  ? book['authors'][0]['name']
                  : 'Unknown Author',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Subjects:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              book['subjects'] != null && book['subjects'].isNotEmpty
                  ? book['subjects'].join(', ')
                  : 'No subjects available',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Download Count:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              book['download_count'] != null
                  ? book['download_count'].toString()
                  : '0',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
