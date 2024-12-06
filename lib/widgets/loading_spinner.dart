import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final double size;

  LoadingSpinner({this.size = 50.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
