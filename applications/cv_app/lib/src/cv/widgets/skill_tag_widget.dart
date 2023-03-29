import 'package:flutter/material.dart';

class SkillTagWidget extends StatelessWidget {
  const SkillTagWidget({Key? key, required this.skill}) : super(key: key);

  final String skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).dividerColor,
      ),
      child: Text(
        skill,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
      ),
    );
  }
}