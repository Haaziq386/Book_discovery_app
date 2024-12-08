import 'package:flutter/material.dart';

class RoundRectangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundRectangleTabIndicator(
      {required Color color, required double weight, required double width})
      : _painter = _RRectanglePainterColor(color, weight, width);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _RRectanglePainterColor extends BoxPainter {
  final Paint _paint;
  final double weight;
  final double width;
  _RRectanglePainterColor(Color color, this.weight, this.width)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Offset customOffset =
        offset + Offset(0, (configuration.size?.height ?? 0) - weight);
    //custom rectangle
    Rect myRect = customOffset & Size(width, weight);
    //custom rounded rectangle
    RRect myRRect = RRect.fromRectXY(myRect, weight, weight);
    canvas.drawRRect(myRRect, _paint);
  }
}
