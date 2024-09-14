import 'package:flutter/material.dart';

class MemoryGridItem extends StatelessWidget {
  final String imageRef;
  final String description;

  const MemoryGridItem({super.key, required this.imageRef, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imageRef),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: const Color.fromRGBO(233, 233, 233, 1),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}