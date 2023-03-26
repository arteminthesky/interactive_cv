part of app_icons;

final DateFormat _monthFormat = DateFormat('EEE');

class CalendarAppIcon extends StatelessWidget {
  const CalendarAppIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    return FittedBox(
      fit: BoxFit.contain,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            _monthFormat.format(now).toUpperCase(),
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w700,
              color: Colors.pinkAccent,
              height: 1.2,
            ),
          ),
          Text(
            DateTime.now().day.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              height: 1,
            ),
          )
        ],
      ),
    );
  }
}
