import 'dart:ui';
import 'package:book_discovery_app/models/book_model.dart';
import 'package:book_discovery_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_discovery_app/widgets/custom_tab_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;
  BookDetailScreen({required this.book});
  @override
  Widget build(BuildContext context) {
    print(book.formats);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Color(0xFFFED6B6),
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    color: Color(0x000),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 25,
                          top: 35,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 32, //is this hardcoding??
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                  'assets/icons/arrow-back.svg'),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.05),
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: book.coverImage != null
                                    ? NetworkImage(book.coverImage!)
                                    : AssetImage(
                                            'assets/icons/book_placeholder.gif')
                                        as ImageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.only(top: 7, left: 25),
                  child: Text('${book.title}',
                      style: GoogleFonts.openSans(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7, left: 25),
                  child: Text('${book.author}',
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400)),
                ),
                Container(
                  // height: 28,
                  margin: EdgeInsets.only(top: 23, left: 0),
                  padding: EdgeInsets.only(left: 0),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          labelPadding: EdgeInsets.all(0),
                          indicatorPadding: EdgeInsets.all(0),
                          isScrollable: true,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          unselectedLabelStyle: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          indicator: RoundRectangleTabIndicator(
                              color: Colors.black, weight: 2, width: 25),
                          tabs: [
                            Tab(
                              child: Container(
                                margin: EdgeInsets.only(right: 35),
                                child: Text('Subjects'),
                              ),
                            ),
                            Tab(
                              child: Container(
                                margin: EdgeInsets.only(right: 35),
                                child: Text('Bookshelves'),
                              ),
                            ),
                            Tab(
                              child: Container(
                                margin: EdgeInsets.only(right: 35),
                                child: Text('Read Online'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: TabBarView(
                              children: [
                                // Subjects Tab
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Text(
                                    book.subjects.join(
                                        '\n'), // Join list elements with newline,
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                // Bookshelves Tab
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Text(
                                    book.bookshelves.join('\n'),
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                // Links Tab
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: ListView.builder(
                                    itemCount: book.formats.length,
                                    itemBuilder: (context, index) {
                                      final formatKey = book.formats.keys
                                          .elementAt(
                                              index); // Get format name (key)
                                      final formatLink = book.formats.values
                                          .elementAt(index); // Get link (value)
                                      return InkWell(
                                        onTap: () async {
                                          if (formatLink.isNotEmpty) {
                                            await launchUrl(Uri.parse(
                                                formatLink)); // Requires `url_launcher` package
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text(
                                            formatKey,
                                            style: GoogleFonts.openSans(
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ]))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('Bookmark it',
              style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
