part of fidgets;

class SiriSuggestionsFidget extends StatelessWidget {
  const SiriSuggestionsFidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var siriSuggestions = context.watch<SiriSuggestions>();
    return FidgetPanel(
      aspectRatio: 4,
      child: ColoredBox(
        color: Colors.white24,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var app in siriSuggestions.applications)
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: AppWidget(
                      app: app,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
