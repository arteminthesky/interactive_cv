part of sections;


class _Section extends StatelessWidget {
  const _Section({
    Key? key,
    required this.header,
    this.body,
  }) : super(key: key);

  final Widget header;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        const SizedBox(height: 6),
        body ?? const Offstage(),
        const SizedBox(height: 40),
      ],
    );
  }
}
