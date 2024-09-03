import 'package:flutter/material.dart';


class ShortVideoThumbnail extends StatelessWidget {
  final String imageRef;
  final String description;

  const ShortVideoThumbnail({
    required this.imageRef,
    required this.description,
    super.key,
  });

  @override
   Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imageRef),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}