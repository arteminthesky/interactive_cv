
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(
      this.text, {
        Key? key,
        this.subtitle,
      }) : super(key: key);

  final String text;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
        if (subtitle != null)
          Text(subtitle!, style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}