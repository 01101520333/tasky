import 'package:flutter/material.dart';
import 'package:tasky/core/utils/assets_icons.dart';

class _ItemTaskPriority extends StatelessWidget {
  const _ItemTaskPriority({
    super.key,
    required this.index,
    required this.isSelected,
    this.onTap,
  });
  final int index;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        margin: EdgeInsets.only(right: 3, bottom: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff5F33E1) : Color(0xff6E6A7C),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xff5F33E1) : Color(0xff6E6A7C),
          ),
        ),
        child: Column(
          spacing: 7,
          children: [
            Image.asset(
              AssetsIcons.priorityIcon,
              height: 24,
              width: 24,
              color: isSelected ? Color(0xffFFFFFF) : null,
            ),

            Text(
              index.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: .bold,
                color: isSelected ? Color(0xffFFFFFF) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
