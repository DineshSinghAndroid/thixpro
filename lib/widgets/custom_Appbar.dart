import 'package:Thixpro/widgets/sementions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../resources/app_theme.dart';

class CustomAppbar extends StatelessWidget {
  final bool? isProfileImage;
  final bool? isLikeButton;
  final String? titleText;
  final GestureTapCallback? openDrawer;

  CustomAppbar({
    super.key,
    required this.titleText,
    this.isProfileImage = false,
    this.isLikeButton = false,
    this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      // elevation: 1,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppTheme.whitebg,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark,
        // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      toolbarHeight: AddSize.size50 * 1.16,
      leadingWidth: AddSize.size100 * .60,
      leading: isProfileImage == true
          ? InkWell(
              onTap: () {},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    return Container(
                      margin: EdgeInsets.only(left: AddSize.padding12),
                      decoration: BoxDecoration(
                        color: AppTheme.filtter,
                        shape: BoxShape.circle,
                        //boxShadow: blurBoxShadow,
                        border: Border.all(color: AppTheme.whitebg),
                      ),
                      height: AddSize.size45,
                      width: AddSize.size45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.asset(
                          '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            )
          : IconButton(
              onPressed: () {
                Get.back();
              },
              padding: EdgeInsets.only(top: AddSize.size15),
              alignment: Alignment.centerLeft,
              icon: Padding(
                padding: EdgeInsets.only(left: AddSize.padding14),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppTheme.primaryColor,
                ),
              )),
      title: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          titleText!,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.filtter,
              fontSize: 20),
        ),
      ),
      actions: [
        // isLikeButton == true
        //     ? Container(
        //   margin:
        //   EdgeInsets.only(right: AddSize.size12, top: AddSize.size10),
        //   padding: EdgeInsets.all(AddSize.size10 * .7),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: AppTheme.filtter.withOpacity(0.2)),
        //     shape: BoxShape.circle,
        //     color: AppTheme.whitebg,
        //   ),
        //   child: GestureDetector(
        //     onTap: () {
        //       Get.toNamed(MyRouter.savedProject);
        //     },
        //     child: Icon(
        //       Icons.favorite,
        //       size: AddSize.size20,
        //       color: AppTheme.subText.withOpacity(0.3),
        //     ),
        //   ),
        // )
        //     : const SizedBox()
      ],
      bottom: PreferredSize(
        preferredSize: Size(AddSize.screenWidth, AddSize.size14),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AddSize.size18),
                  bottomRight: Radius.circular(AddSize.size18)),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    color: AppTheme.primaryColor.withOpacity(.085),
                    blurRadius: 4),
                const BoxShadow(
                    offset: Offset(0, -1), color: Colors.white, blurRadius: 1),
              ]),
          height: AddSize.size18,
        ),
      ),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(10),
      //   ),
      // ),
    );
  }
}
