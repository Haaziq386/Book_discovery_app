import 'package:flutter/material.dart';
import 'book_detail_screen.dart';
import '../widgets/book_item.dart';
import '../widgets/loading_spinner.dart';
import '../services/api_service.dart';
import '../models/book_model.dart';
import '../utils/pagination_helper.dart';
import '../utils/constants.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final ApiService apiService = ApiService(baseUrl: baseUrl);
  final PaginationHelper paginationHelper = PaginationHelper();

  List<BookModel> books = [];
  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks({bool isSearch = false}) async {
    if (paginationHelper.isLoading) return;

    setState(() {
      paginationHelper.setLoading(true);
    });

    try {
      final data = await apiService.fetchBooks(
        isSearch && searchTerm.isNotEmpty
            ? "$baseUrl?search=$searchTerm"
            : paginationHelper.nextUrl ?? baseUrl,
      );

      setState(() {
        if (isSearch) {
          books = (data['results'] as List).map((json) => BookModel.fromJson(json)).toList();
        } else {
          books.addAll((data['results'] as List).map((json) => BookModel.fromJson(json)));
        }
        paginationHelper.setNextUrl(data['next']);
      });
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      setState(() {
        paginationHelper.setLoading(false);
      });
    }
  }

  void onSearchChanged(String query) {
    setState(() {
      searchTerm = query;
    });
    fetchBooks(isSearch: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Discovery'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by title, author...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: onSearchChanged,
            ),
          ),
          // Book List
          Expanded(
            child: books.isEmpty && paginationHelper.isLoading
                ? LoadingSpinner()
                : ListView.builder(
                    itemCount: books.length + 1,
                    itemBuilder: (context, index) {
                      if (index == books.length) {
                        if (paginationHelper.shouldLoadMore()) {
                          fetchBooks();
                          return LoadingSpinner(size: 30);
                        } else {
                          return SizedBox.shrink();
                        }
                      }

                      final book = books[index];
                      return BookItem(
                        book: {
                          'title': book.title,
                          'formats': {'image/jpeg': book.coverImage},
                          'authors': [
                            {'name': book.author}
                          ]
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailScreen(book: {
                                'title': book.title,
                                'formats': {'image/jpeg': book.coverImage},
                                'authors': [
                                  {'name': book.author}
                                ]
                              }),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
