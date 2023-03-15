part of widgets;

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({Key? key, required this.desktop}) : super(key: key);

  final Desktop desktop;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            for (int i = 0; i < 6; i++)
              Expanded(
                child: Row(
                  children: [
                    for (int j = 0; j < 4; j++)
                      desktop.applications.length > i * 4 + j
                          ? Expanded(
                              child: _WidgetSelector(
                                item: desktop.applications[i * 4 + j],
                              ),
                            )
                          : const Expanded(child: Offstage()),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _WidgetSelector extends StatelessWidget {
  const _WidgetSelector({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Application item;

  @override
  Widget build(BuildContext context) {
    return AppWidget(app: item);
  }
}
