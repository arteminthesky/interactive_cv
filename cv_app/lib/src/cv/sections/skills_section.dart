part of sections;

class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key, required this.skills}) : super(key: key);

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return _Section(
      header: const SectionHeader('Skills'),
      body: Wrap(
        spacing: 10,
        runSpacing: 5,
        children: skills.map((e) => SkillTagWidget(skill: e)).toList(),
      ),
    );
  }
}


