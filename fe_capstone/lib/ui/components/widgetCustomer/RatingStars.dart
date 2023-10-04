import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {

  final int rating;

  const RatingStars({
    required this.rating
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );

  }

}