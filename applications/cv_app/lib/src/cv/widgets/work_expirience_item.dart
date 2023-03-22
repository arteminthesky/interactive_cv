import 'package:cv_app/src/domain/job.dart';
import 'package:flutter/material.dart';
import 'package:cv_app/src/utils/date_utils.dart';

class WorkExpirienceItem extends StatelessWidget {
  const WorkExpirienceItem({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: job.companyLogo != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(job.companyLogo!),
                    )
                  : null,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black45, width: 2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.companyName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (job.activityKind != null) Text(job.activityKind!,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      job.startDate?.formatToMonthWithYear() ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                    const Text(
                      ' - ',
                      style: TextStyle(color: Colors.black45),
                    ),
                    Text(
                      job.endDate?.formatToMonthWithYear() ?? 'nowadays',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
