import 'package:flutter/material.dart';
import 'package:book_discovery_app/models/book_model.dart';
import 'package:book_discovery_app/utils/constants.dart';

class BookItem extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;

  BookItem({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Larger image with a fixed size
            book.coverImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    child: Image.network(
                      book.coverImage!,
                      width: 80, // Adjust width
                      height: 120, // Adjust height
                      fit: BoxFit.fill,
                    ),
                  )
                : Icon(Icons.book, size: 80), // Fallback icon with similar size
            const SizedBox(width: 12), // Spacing between image and text
            // Book details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // Handle long titles
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
