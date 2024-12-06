import 'package:flutter/material.dart';
import 'package:book_discovery_app/models/book_model.dart';

class BookItem extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;

  BookItem({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.coverImage != null
          ? Image.network(
              book.coverImage!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          : Icon(Icons.book, size: 50),
      title: Text(book.title),
      subtitle: Text('${book.author}'),
      // subtitle: Text('${book.author}\n${book.subjects.join(", ")}'),
      // isThreeLine: true,
      onTap: onTap,
    );
  }
}
