import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../model/prize_winner_model.dart';

class PrizeWinnersWidget extends StatelessWidget {
  final List<PrizeGroup> groups;
  const PrizeWinnersWidget({super.key, required this.groups});

  String _monthYearLabel(int month, int year) {
    final dt = DateTime(year, month);
    return "${DateFormat.MMMM().format(dt)} $year";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: groups.length,
      separatorBuilder: (_, __) => SizedBox(height: 18.h),
      itemBuilder: (context, idx) {
        final group = groups[idx];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_monthYearLabel(group.month, group.year)} • ${group.name}",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                Text("${group.topUsers.length} Winners",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey))
              ],
            ),
            SizedBox(height: 12.h),

            // Prizes list
            SizedBox(
              height: 140.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: group.entries.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, i) {
                  final entry = group.entries[i];
                  return Container(
                    width: 180.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12.r)),
                          child: Image.network(
                            entry.icon,
                            height: 90.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 90.h,
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  "#${entry.rank}",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  entry.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 12.h),

            // Top users
            if (group.topUsers.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Winners",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 80.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: group.topUsers.length,
                      separatorBuilder: (_, __) => SizedBox(width: 12.w),
                      itemBuilder: (context, i) {
                        final user = group.topUsers[i];
                        final amount =
                        user.closer.isNotEmpty ? user.closer.first.amount : 0.0;

                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundImage: NetworkImage(user.profilePicture),
                            ),
                            SizedBox(height: 6.h),
                            Text(user.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600)),
                            Text("€$amount",
                                style: TextStyle(
                                    fontSize: 11.sp, color: Colors.grey))
                          ],
                        );
                      },
                    ),
                  )
                ],
              )
          ],
        );
      },
    );
  }
}
