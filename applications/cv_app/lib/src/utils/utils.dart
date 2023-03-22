// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Center(
// child: Header(
// _profile.name,
// subtitle: _profile.bio,
// ),
// ),
// Column(
// children: [
// Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// Text('Age:'),
// Text('22'),
// ],
// ),
// Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// Text('Sex:'),
// Text('male'),
// ],
// ),
// ],
// ),
// SectionHeader('Contact Information'),
// Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// IconButton(
// icon: Icon(AppIcons.github_circled),
// onPressed: () {},
// iconSize: 30,
// ),
// IconButton(
// icon: Icon(AppIcons.mail),
// onPressed: () {},
// iconSize: 30,
// ),
// IconButton(
// icon: Icon(AppIcons.telegram),
// onPressed: () {},
// iconSize: 30,
// ),
// ],
// ),
// Center(child: SectionHeader('Work Experience')),
// // StepWidget(steps: [
// //   if (_profile.workExperience != null)
// //     ..._profile.workExperience!
// //         .map((e) => WorkExpirienceItem(job: e))
// //         .toList(),
// // ]),
// ],
// ),