import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookMark extends StatelessWidget {
  const BookMark({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmark_add,
                  color: Colors.brown,
                ),
                SizedBox(
                  width: 10.w,
                ),
                const Text(
                  'QS. Alfatihah : Ayat 7',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(
                    2.5,
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
