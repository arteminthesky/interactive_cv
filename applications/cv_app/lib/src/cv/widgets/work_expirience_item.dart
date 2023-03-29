import 'package:cv_app/src/domain/job.dart';
import 'package:cv_app/src/utils/date_utils.dart';
import 'package:flutter/material.dart';

class WorkExpirienceItem extends StatelessWidget {
  const WorkExpirienceItem({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 55,
              width: 55,
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
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  job.companyName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (job.activityKind != null)
                  Text(
                    job.activityKind!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      job.startDate?.formatToMonthWithYear() ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black45),
                    ),
                    Text(
                      ' - ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black45),
                    ),
                    Text(
                      job.endDate?.formatToMonthWithYear() ?? 'nowadays',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black45),
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
