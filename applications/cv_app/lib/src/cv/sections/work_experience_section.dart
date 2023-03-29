part of sections;

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({Key? key, required this.workExperience})
      : super(key: key);

  final List<Job> workExperience;

  @override
  Widget build(BuildContext context) {
    return _Section(
      header: const SectionHeader('Work Experience'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: workExperience.reversed.map((e) => WorkExpirienceItem(job: e)).toList(),
      ),
    );
  }
}
