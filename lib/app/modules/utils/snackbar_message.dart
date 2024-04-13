import 'package:get/get.dart';
import 'package:myalquran/app/constant/color.dart';

void snackbarMessage(String title, String message) {
  Get.snackbar(
    title,
    message,
    colorText: appBlack,
    backgroundColor: appWhite,
  );
}
