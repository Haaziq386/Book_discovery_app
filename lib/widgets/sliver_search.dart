import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundWave extends StatelessWidget {
  final double height;

  const BackgroundWave({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipPath(
          clipper: BackgroundWaveClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFFACCCC), Color(0xFFF6EFE9)],
            )),
          )),
    );
  }
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    const minSize = 140.0;

    // when h = max = 280
    // h = 280, p1 = 210, p1Diff = 70
    // when h = min = 140
    // h = 140, p1 = 140, p1Diff = 0
    final p1Diff = ((minSize - size.height) * 0.5).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, minSize);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  final ValueChanged<String> onSearchChanged; // Callback for search input

  const SliverSearchAppBar({required this.onSearchChanged});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.5;
    double topPadding = MediaQuery.of(context).padding.top + 16;
    double leftPadding = MediaQuery.of(context).padding.left;
    const pink = const Color(0xFFFACCCC);
    const grey = const Color(0xFFF2F2F7);

    return Stack(
      children: [
        const BackgroundWave(
          height: 280,
        ),
        // Title
        Positioned(
          top: topPadding + 16,
          left: leftPadding + 16,
          child: Text(
            'BOOK-INATOR',
            style: GoogleFonts.yujiMai(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //Image , i want it to be half behind the search bar
        Positioned(
          top: topPadding,
          right: 16,
          child: Image.asset(
            'assets/images/book.png',
            width: 120,
            height: 120,
          ),
        ),
        //search bar
        Positioned(
          top: topPadding + offset,
          left: 16,
          right: 16,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by title, author...',
                filled: true,
                fillColor: Colors.white,
                focusColor: pink,
                focusedBorder: _border(pink),
                border: _border(grey),
                enabledBorder: _border(grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              onChanged: onSearchChanged,
            ),
          ),
        )
      ],
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: color),
        borderRadius: BorderRadius.circular(12),
      );

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
