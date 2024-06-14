import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final Function() onExpand;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    required this.onExpand
  });

  @override
  State<StatefulWidget> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.blueGrey, // Border color
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Remove top divider
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              _customTileExpanded
                  ? Icons.arrow_drop_down_circle
                  : Icons.arrow_drop_down,
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _customTileExpanded = expanded;
                widget.onExpand();
              });
            },
            initiallyExpanded: widget.initiallyExpanded,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}
