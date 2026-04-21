import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management/constant/colors.dart';
import 'package:student_management/constant/sizes.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.action,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.leading = true,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? action;
  final VoidCallback? leadingOnPressed;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading
          ? IconButton(
              onPressed: leadingOnPressed ?? () => Get.back(),
              icon: Icon(
                leadingIcon ?? Icons.arrow_back,
              ),
            )
          : null,
      title: title,
      actions: action,
      centerTitle: true,
      elevation: 0,
      backgroundColor: TColors.primary,
      titleSpacing: TSizes.md,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}