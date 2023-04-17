part of options;

class OptionItem extends StatelessWidget {
  const OptionItem({
    Key? key,
    required this.option,
    this.onClick,
  }) : super(key: key);

  final Option option;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenuAction(
      child: Text(
        option.name(context),
      ),
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    option.onClick(context);
    onClick?.call();
  }
}
