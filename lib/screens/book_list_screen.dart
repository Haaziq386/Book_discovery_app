import 'package:flutter/material.dart';
import 'book_detail_screen.dart';
import '../widgets/book_item.dart';
import '../widgets/loading_spinner.dart';
import '../services/api_service.dart';
import '../models/book_model.dart';
import '../widgets/sliver_search.dart';
import '../widgets/debouncer.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final ScrollController _scrollController = ScrollController();
  final ApiProvider _apiProvider = ApiProvider();
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  List<BookModel> books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent * 0.7 &&
          !_isLoading) {
        _fetchBooks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _fetchBooks([String? query]) async {
    print("---------------Fetching-----------");
    setState(() {
      _isLoading = true;
    });
    try {
      // Fetch books for the current page
      print("current page: $_currentPage");
      List<BookModel> newBooks;
      if (query?.isNotEmpty == true) {
        _clearBooks();
        newBooks = await _apiProvider.searchBooks(query!);
      } else {
        newBooks = await _apiProvider.fetchBooks(_currentPage, _pageSize);
      }

      setState(() {
        books.addAll(newBooks);
        _currentPage++; // Increment the page for the next fetch
      });
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearBooks() {
    print("---------------Clear-----------");
    setState(() {
      books.clear();
      _currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Color(0xFF7EA4F3),
      Color(0xFFF0A55E),
      Color(0xFFED628A),
      Color(0xFFA47EF4),
      Color(0xFF68E3BD)
    ];
    return Scaffold(
      body: CustomScrollView(
        controller:
            _scrollController, // Use scroll controller   -have to see to this
        slivers: [
          // Add the SliverSearchAppBar
          SliverPersistentHeader(
            delegate: SliverSearchAppBar(
              clearBooks: _clearBooks,
              fetchBooks: _fetchBooks,
              searchController: _searchController,
              debouncer: _debouncer,
            ), //-----------------to change
            pinned: true,
          ),
          // Add the book list as a SliverList
          books.isEmpty && _isLoading
              ? SliverToBoxAdapter(
                  child: Center(
                    child: LoadingSpinner(),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == books.length) {
                        return _isLoading
                            ? LoadingSpinner(size: 30)
                            : SizedBox.shrink();
                      }

                      final book = books[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: colors[index % colors.length],
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(4, 4),
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
                    childCount: books.length + 1, // Add one for the spinner
                  ),
                ),
        ],
      ),
    );
  }
}
