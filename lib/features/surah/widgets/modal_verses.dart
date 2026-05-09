import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myalquran/core/constant/color.dart';
import 'package:myalquran/shared/widgets/text_custom.dart';

class ModalVerses extends StatelessWidget {
  final String surahName;
  final int verseNumber;
  final bool isBookmarked;
  final VoidCallback onLastRead;
  final VoidCallback onBookmark;

  const ModalVerses({
    super.key,
    required this.surahName,
    required this.verseNumber,
    required this.isBookmarked,
    required this.onLastRead,
    required this.onBookmark,
  });

  static Future<void> show({
    required BuildContext context,
    required String surahName,
    required int verseNumber,
    required bool isBookmarked,
    required VoidCallback onLastRead,
    required VoidCallback onBookmark,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ModalVerses(
        surahName: surahName,
        verseNumber: verseNumber,
        isBookmarked: isBookmarked,
        onLastRead: onLastRead,
        onBookmark: onBookmark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextCustom(
                'QS. $surahName : Ayat $verseNumber',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          _TileFeature(
            icon: Icons.book,
            title: 'Tandai Terakhir Membaca',
            onTap: () {
              Navigator.pop(context);
              onLastRead();
            },
          ),
          _TileFeature(
            icon: isBookmarked ? Icons.bookmark : Icons.bookmark_add,
            title: isBookmarked ? 'Sudah Terbookmark' : 'Simpan ke Bookmark',
            disable: isBookmarked,
            onTap: isBookmarked
                ? null
                : () {
                    Navigator.pop(context);
                    onBookmark();
                  },
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class _TileFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool disable;

  const _TileFeature({
    required this.icon,
    required this.title,
    this.onTap,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              color: disable ? appGrey : appBlueLight1,
              size: 28.sp,
            ),
            title: TextCustom(
              title,
              fontSize: 14.sp,
              color: disable ? appGrey : appBlack,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const Divider(thickness: 0.6),
          ),
        ],
      ),
    );
  }
}
