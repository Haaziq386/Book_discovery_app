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
  ScrollController?
      _scrollController; // Nullable ScrollController -> added to handle hot reloads

  List<BookModel> books = [];
  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    _initializeScrollController();
    fetchBooks();
  }

  void _initializeScrollController() {
    _scrollController
        ?.dispose(); // Dispose old controller if hot reload caused issues
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  Future<void> fetchBooks({bool isSearch = false}) async {
    if (!isSearch && !paginationHelper.shouldLoadMore()) return;

    setState(() {
      paginationHelper.setLoading(true);
    });

    try {
      final data = await apiService.fetchBooks(
        isSearch && searchTerm.isNotEmpty
            ? "$baseUrl?search=$searchTerm"
            : paginationHelper.nextUrl ??
                baseUrl, // initial loading not happening could be due to this line :: as nexturl not set intially
        //solved by adding baseUrl as default value in  PaginationHelper class
      );

      setState(() {
        print("json: ${data}"); //debugging statement
        if (isSearch) {
          books = (data['results'] as List)
              .map((json) => BookModel.fromJson(json))
              .toList();
          paginationHelper
              .setNextUrl(data['next']); // Reset pagination for search
        } else {
          books.addAll((data['results'] as List)
              .map((json) => BookModel.fromJson(json)));
          paginationHelper.setNextUrl(data['next']); // Set next URL
        }
      });
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      setState(() {
        paginationHelper.setLoading(false);
      });
    }
  }

  void _scrollListener() {
    if (_scrollController != null &&
        _scrollController!.position.pixels ==
            _scrollController!.position.maxScrollExtent) {
      fetchBooks(); // Trigger fetch when reaching the end of the list -> allowing going to next page of API
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
    if (books.isEmpty && !paginationHelper.isLoading) {
      fetchBooks(); // Fetch books if the list is empty (handles hot restart case)
    }

    final List<Color> colors = [
      Color(0xFF7EA4F3),
      Color(0xFFF0A55E),
      Color(0xFFED628A),
      Color(0xFFA47EF4),
      Color(0xFF68E3BD)
    ];

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
                    controller: _scrollController, // Use the scroll controller
                    itemCount:
                        books.length + 1, // Add one for the loading spinner
                    itemBuilder: (context, index) {
                      if (index == books.length) {
                        // Show spinner at the bottom during loading
                        return paginationHelper.isLoading
                            ? LoadingSpinner(size: 30)
                            : SizedBox.shrink();
                      }

                      final book = books[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: colors[index % colors.length],
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(4, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: BookItem(
                          book: book,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailScreen(book: book),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
