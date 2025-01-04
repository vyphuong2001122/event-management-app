import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onSeeMore;
  const SectionWidget({
    Key? key,
    required this.title,
    required this.content,
    this.onSeeMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            if (onSeeMore != null)
              InkWell(
                onTap: onSeeMore,
                child: const Text(
                  'See more',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        content,
      ],
    );
  }
}
