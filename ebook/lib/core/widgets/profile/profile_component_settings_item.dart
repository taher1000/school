import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import 'icon_style.dart';
import 'settings_screen_utils.dart';

class SettingsItem extends StatelessWidget {
  final IconData icons;
  final IconStyle? iconStyle;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final int? titleMaxLine;
  final int? subtitleMaxLine;
  final TextOverflow? overflow;
  final Color? cardBackgroundColor;
  const SettingsItem(
      {required this.icons,
      this.iconStyle,
      required this.title,
      this.titleStyle,
      this.subtitle,
      this.subtitleStyle,
      this.backgroundColor,
      this.trailing,
      this.onTap,
      this.titleMaxLine,
      this.subtitleMaxLine,
      this.overflow = TextOverflow.ellipsis,
      this.cardBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: cardBackgroundColor ?? ColorManager.secondryLight,
        child: ListTile(
          onTap: onTap,
          leading: (iconStyle != null && iconStyle!.withBackground!)
              ? Container(
                  decoration: BoxDecoration(
                    color:
                        iconStyle!.backgroundColor ?? ColorManager.darkGreyText,
                    borderRadius:
                        BorderRadius.circular(iconStyle!.borderRadius!),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    icons,
                    size: SettingsScreenUtils.settingsGroupIconSize,
                    color: iconStyle!.iconsColor,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    icons,
                    size: SettingsScreenUtils.settingsGroupIconSize,
                  ),
                ),
          title: Text(
            title,
            style: titleStyle ??
                TextStyleManager.getSemiBoldStyle(
                    color: ColorManager.darkPrimary, fontSize: FontSize.s18),
            maxLines: titleMaxLine,
            overflow: titleMaxLine != null ? overflow : null,
          ),
          subtitle: (subtitle != null)
              ? Text(
                  subtitle!,
                  style: subtitleStyle ??
                      TextStyleManager.getMediumStyle(
                          color: ColorManager.darkPrimary),
                  maxLines: subtitleMaxLine,
                  overflow:
                      subtitleMaxLine != null ? TextOverflow.ellipsis : null,
                )
              : null,
          trailing: (trailing != null) ? trailing : Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
