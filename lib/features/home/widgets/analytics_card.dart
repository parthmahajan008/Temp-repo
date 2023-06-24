import 'package:flutter/material.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({
    super.key,
    required this.heading,
    required this.bottomText,
    required this.icon,
  });
  final String heading;
  final String bottomText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 5,
              ),
              Text(
                heading,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            width: 150,
            alignment: Alignment.center,
            child: const Text(
              "Graph",
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              bottomText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
