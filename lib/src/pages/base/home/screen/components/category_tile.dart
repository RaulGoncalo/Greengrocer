import 'package:flutter/material.dart';
import 'package:quitanda/src/config/custom_colors.dart';

class CategoryTile extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryTile(
      {super.key,
      required this.categorie,
      required this.isSelected,
      required this.onPressed});

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: widget.onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
              color: widget.isSelected
                  ? CustomColors.customSwatchColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.categorie,
            style: TextStyle(
              color: widget.isSelected
                  ? Colors.white
                  : CustomColors.customContrastColor,
              fontWeight: FontWeight.bold,
              fontSize: widget.isSelected ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
