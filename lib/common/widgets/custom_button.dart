import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black12)),
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color ?? Colors.black,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 19,
          color: color == null ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
