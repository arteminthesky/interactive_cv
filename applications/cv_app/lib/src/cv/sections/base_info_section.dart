part of sections;


class BaseInfoSection extends StatelessWidget {
  const BaseInfoSection({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return _Section(
      header: Header(
        profile.name,
        subtitle: profile.bio,
      ),
      body: Table(
        columnWidths: {
          0: FixedColumnWidth(70),
        },
        children: [
          TableRow(
            children: [
              const Text(
                'Age:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(profile.age.toString()),
            ],
          ),
          TableRow(
            children: [
              const Text(
                'Sex:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(profile.sex),
            ],
          ),
          TableRow(
            children: [
              const Text(
                'Country:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(profile.country),
            ],
          ),
        ],
      ),
    );
  }
}
