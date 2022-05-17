import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool? isSelected;
  final Function? onTap;

  const TabItem({this.text, this.icon, this.isSelected, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected == true ? Colors.black : Colors.grey,
            ),
            Text(
              text.toString(),
              style: TextStyle(
                  color: isSelected == true ? Colors.black : Colors.grey,
                  fontWeight:
                      isSelected == true ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 12),
            )
          ],
        ),
      ),
      onTap: () {
        return onTap!();
      },
    );
  }
}
