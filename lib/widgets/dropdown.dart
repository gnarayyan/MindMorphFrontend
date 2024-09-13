import 'package:flutter/material.dart';
import 'package:mindmorph/constants/constants.dart';

class MindMorphDropdown extends StatefulWidget {
  final String hint;
  final Map<String, String> items;
  final String? selectedItem;
  final Function(String?) onChanged;
  final int? contentMaxLength;

  const MindMorphDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.contentMaxLength,
  });

  @override
  State<MindMorphDropdown> createState() => _MindMorphDropdownState();
}

class _MindMorphDropdownState extends State<MindMorphDropdown> {
  @override
  Widget build(BuildContext context) {
    String? choice = widget.selectedItem;
    final dynamicColor = widget.items.isEmpty ? Colors.grey : featureColor;
    return DropdownButton<String>(
      hint: Text(
        '${widget.hint}  ',
        style: TextStyle(color: dynamicColor, fontSize: 16),
      ),
      icon: Icon(Icons.arrow_downward, size: 16, color: dynamicColor),
      value: choice,
      onChanged: (String? value) {
        choice = value;
        widget.onChanged(value);
      },
      items: widget.items.entries.map<DropdownMenuItem<String>>((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(
            widget.contentMaxLength == null
                ? entry.value
                : entry.value.substring(0, widget.contentMaxLength),
            style: const TextStyle(color: textFormFieldColor, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
