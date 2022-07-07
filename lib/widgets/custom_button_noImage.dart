import 'package:flutter/material.dart';

class CustomButton02 extends StatelessWidget {
  const CustomButton02({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.blue.shade900,
        animationDuration: const Duration(microseconds: 1),
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: onTap,

      // const SizedBox(
      //   width: 30,
      // ),
      child: Text(text),
    );
  }
}
