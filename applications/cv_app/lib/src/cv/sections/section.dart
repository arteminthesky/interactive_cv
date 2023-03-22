part of sections;


class _Section extends StatelessWidget {
  const _Section({
    Key? key,
    required this.header,
    required this.body,
  }) : super(key: key);

  final Widget header;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        const SectionDivider(),
        body,
        const SizedBox(height: 20),
      ],
    );
  }
}
