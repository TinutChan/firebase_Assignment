import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String image;
  const CustomIcon({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
        ),
      ),
    );
  }
}
