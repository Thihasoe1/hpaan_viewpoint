import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !_isExpanded,
            child: Text(
              widget.text,
              maxLines: 3,
              textScaler: const TextScaler.linear(1),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "SF-Pro",
              ),
            ),
          ),
          Visibility(
            visible: !_isExpanded,
            child: Text(
              widget.text,
              textScaler: const TextScaler.linear(1),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "SF-Pro",
              ),
            ),
          ),
          Text(
            _isExpanded ? "See Less" : "See More",
            style: const TextStyle(
              color: Colors.blue,
              fontFamily: "SF-Pro",
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
