import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final Map<String, dynamic> book;
  final VoidCallback onTap;

  BookItem({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book['formats']['image/jpeg'] != null
          ? Image.network(
              book['formats']['image/jpeg'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          : Icon(Icons.book, size: 50),
      title: Text(book['title']),
      subtitle: Text(
        book['authors'].isNotEmpty ? book['authors'][0]['name'] : 'Unknown Author',
      ),
      onTap: onTap,
    );
  }
}
