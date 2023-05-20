import 'package:drink_store/app/models/item_model.dart';
import 'package:drink_store/app/themes/main_theme.dart';
import 'package:drink_store/app/untils/untils_price.dart';
import 'package:flutter/material.dart';

import '../../../../app/components/favorite_buttom.dart';

class ItemTile extends StatelessWidget {
  ItemTile({super.key, required this.item, required this.onPressed, required this.onTap});

  final ItemModel item;
  final VoidCallback onPressed;
  final VoidCallback onTap;
  final UntilPrice untilPrice = UntilPrice();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //imagem aqui
                  Expanded(child: Hero(tag: item.image, child: Image.asset(item.image, fit: BoxFit.cover))),
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorTheme.primary),
                  ),
                  Text(untilPrice.localPrice(item.price),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorTheme.primary)),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: FavoriteButtom(
            isFavorite: item.favorite,
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
