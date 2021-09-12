import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  const FABBottomAppBar({
    Key? key,
    required this.items,
    required this.centerItemText,
    required this.onTabSelected,
    this.iconSize = 20.0,
    required this.selectedColor,
    required this.backgroundColor,
    required this.unselectedColor,
    this.height = 70,
  }) : super(key: key);

  final String centerItemText;
  final double height;
  final double iconSize;
  final Color unselectedColor;
  final Color selectedColor;
  final Color backgroundColor;
  final List<FABBottomAppBarItem> items;
  final ValueChanged<int> onTabSelected;

  @override
  _FABBottomAppBarState createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
      shape: CircularNotchedRectangle(),
    );
  }

  Widget _buildTabItem(
      {required FABBottomAppBarItem item,
      required int index,
      required ValueChanged<int> onPressed}) {
    Color color =
        _selectedIndex == index ? widget.selectedColor : widget.unselectedColor;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
