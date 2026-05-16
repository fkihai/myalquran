import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myalquran/core/routes/route_names.dart';
import 'package:myalquran/domain/entities/bookmark.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_bloc.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_event.dart';
import 'package:myalquran/shared/widgets/text_custom.dart';

class ListBookmarkWidget extends StatelessWidget {
  final List<Bookmark> bookmarks;
  const ListBookmarkWidget({super.key, required this.bookmarks});

  @override
  Widget build(BuildContext context) {
    if (bookmarks.isEmpty) {
      return const Center(
        child: TextCustom('Tidak Ada Data'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      itemCount: bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = bookmarks[index];
        return InkWell(
          onTap: () {
            context.push(
              Routes.toDetailSurah(
                bookmark.surahId,
                bookmark.verseNumber,
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: TextCustom(
                  'Hapus Bookmark?',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                content: TextCustom(
                  'Apakah anda yakin ingin menghapus bookmark ini?',
                  fontSize: 14.sp,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('BATAL'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (bookmark.id != null) {
                        context
                            .read<BookmarkBloc>()
                            .add(DeleteBookmarkEvent(bookmark.id!));
                      }
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('HAPUS'),
                  ),
                ],
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmark_add,
                  color: Colors.brown,
                ),
                SizedBox(width: 10.w),
                TextCustom(
                  'QS. ${bookmark.surahName} : Ayat ${bookmark.verseNumber}',
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
