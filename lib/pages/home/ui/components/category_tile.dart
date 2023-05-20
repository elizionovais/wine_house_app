import 'package:flutter/material.dart';

import '../../../../app/themes/main_theme.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.title,
    required this.onPressed,
    this.trailing,
    this.leading,
    required this.selected,
  });

  final Widget? trailing;
  final Widget? leading;
  final String title;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: selected ? ColorTheme.primary : Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Text(title,
              style: selected
                  ? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)
                  : TextStyle(fontSize: 14, color: ColorTheme.primary)),
        ),
      ),
    );
  }
}
