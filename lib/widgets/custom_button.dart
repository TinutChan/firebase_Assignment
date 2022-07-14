import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icons,
    this.colors,
  }) : super(key: key);
  final String text;
  final IconData icons;
  final Color? colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: FaIcon(icons, color: colors),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPrimary: Colors.white,
        primary: Colors.blue.shade900,
        animationDuration: const Duration(microseconds: 1),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: onTap,
    );
  }
}
