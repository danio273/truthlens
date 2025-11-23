import 'package:flutter/material.dart';

class ToggleSelector extends StatelessWidget {
  final double width;
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const ToggleSelector({
    super.key,
    required this.width,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: ToggleButtons(
          isSelected: List.generate(options.length, (i) => i == selectedIndex),
          onPressed: onChanged,
          borderRadius: BorderRadius.circular(12),
          constraints: BoxConstraints(
            minHeight: 40,
            minWidth: width / options.length,
          ),
          children: options
              .map(
                (label) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(label, textAlign: TextAlign.center),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}