import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FavoriteButtom extends StatefulWidget {
  FavoriteButtom({
    super.key,
    this.isFavorite = false,
    this.backgroundColor,
  });

  bool isFavorite;
  final Color? backgroundColor;

  @override
  State<FavoriteButtom> createState() => _FavoriteButtomState();
}

class _FavoriteButtomState extends State<FavoriteButtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
          onTap: () {
            setState(() {
              widget.isFavorite = !widget.isFavorite;
            });
          },
          child:
              widget.isFavorite ? const Icon(Icons.favorite, color: Colors.black) : const Icon(Icons.favorite_border)),
    );
  }
}
