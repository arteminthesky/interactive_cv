part of sections;

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({Key? key, required this.workExperience})
      : super(key: key);

  final List<Job> workExperience;

  @override
  Widget build(BuildContext context) {
    return _Section(
      header: const SectionHeader('Work Experience'),
      body: StepWidget(
        steps: workExperience.map((e) => WorkExpirienceItem(job: e)).toList(),
      ),
    );
  }
}
