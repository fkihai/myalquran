import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/color.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.onChange});
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: appBlueLight3.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: controllerField,
                  onChanged: onChange,
                  cursorColor: appBlueLight2,
                  decoration: InputDecoration(
                    hintText: "Search surah",
                    hintStyle: TextStyle(fontSize: 15.sp, color: appGrey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Icon(Icons.search, size: 25.0),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
