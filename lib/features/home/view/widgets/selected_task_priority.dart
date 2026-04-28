import 'package:flutter/material.dart';
import 'package:tasky/core/utils/assets_icons.dart';
import 'package:tasky/core/utils/colors_app.dart';

class SelectedTaskPriority extends StatefulWidget {
  SelectedTaskPriority({super.key, required this.callBackPriority});

  void Function(int priority) callBackPriority;

  @override
  State<SelectedTaskPriority> createState() => _SelectedTaskPriorityState();
}

class _SelectedTaskPriorityState extends State<SelectedTaskPriority> {
  final List<int> priorityIndex = List.generate(10, (index) => index + 1);

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .center,
        children: [
          Text(
            "Task Priority",
            style: TextStyle(
              fontSize: 16,
              fontWeight: .bold,
              color: ColorsApp.textColor,
            ),
          ),
          Divider(),
        ],
      ),

      content: Wrap(
        children: priorityIndex
            .map<Widget>(
              (index) => _ItemTaskPriority(
                index: index,
                isSelected: index == selectedIndex,
                onTap: () {
                  selectedIndex = index;
                  widget.callBackPriority(selectedIndex);
                  setState(() {});
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

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
          color: isSelected ? Color(0xff5F33E1) : Color(0xffFFFFFF),
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
              // color: isSelected ? Colors.white : null,
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
