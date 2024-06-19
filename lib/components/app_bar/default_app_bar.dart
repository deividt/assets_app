import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../theme/theme_colors.dart';
import '../images/image_tokens.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.showLogo = false,
  });

  final String title;
  final bool showBackButton;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: ThemeColors.primaryTextColor,
              onPressed: () => context.pop(),
            )
          : null,
      title: showLogo
          ? SvgPicture.asset(
              ImageTokens.tractianLogo,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              height: 17,
              width: 126,
            )
          : Text(
              title,
              style: const TextStyle(
                color: ThemeColors.primaryTextColor,
              ),
            ),
      backgroundColor: ThemeColors.appBarBackgroundColor,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
