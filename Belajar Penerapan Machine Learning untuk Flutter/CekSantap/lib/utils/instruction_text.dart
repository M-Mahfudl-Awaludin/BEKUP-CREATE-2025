import 'package:flutter/material.dart';

class InstructionText extends StatefulWidget {
  final String text;
  final int trimLength;

  const InstructionText({
    super.key,
    required this.text,
    this.trimLength = 150,
  });

  @override
  State<InstructionText> createState() => _InstructionTextState();
}

class _InstructionTextState extends State<InstructionText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final displayText = isExpanded || widget.text.length <= widget.trimLength
        ? widget.text
        : "${widget.text.substring(0, widget.trimLength)}...";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: const TextStyle(fontSize: 15, height: 1.5),
          textAlign: TextAlign.justify,
        ),
        if (widget.text.length > widget.trimLength)
          TextButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? "Read less" : "Read more",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.orange,
              ),
            ),
          ),
      ],
    );
  }
}
