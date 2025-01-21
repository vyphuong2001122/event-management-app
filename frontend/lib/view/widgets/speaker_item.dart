import 'package:event_management_app/models/speaker.dart';
import 'package:flutter/material.dart';

class SpeakerItem extends StatefulWidget {
  final Speaker speaker;
  final double width;
  const SpeakerItem({super.key, required this.speaker, this.width = 200});

  @override
  State<SpeakerItem> createState() => _SpeakerItemState();
}

class _SpeakerItemState extends State<SpeakerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: widget.width,
            height: 200,
            child: Image.asset(
              'assets/images/avatar_illustration.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.speaker.name,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.speaker.bio,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
