import 'package:flutter/material.dart';
import '/screens/book_list_screen.dart';

void main() {
  runApp(BookDiscoveryApp());
}

class BookDiscoveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Discovery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookListScreen(),
    );
  }
}
