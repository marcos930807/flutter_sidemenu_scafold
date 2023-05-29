import 'package:flutter/material.dart';

import 'maybe_tooltip.dart';

/// The items for the menu.
class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key? key,
    required this.width,
    required this.menuWidth,
    required this.onTap,
    this.selected = false,
    required this.icon,
    required this.label,
    this.showDivider = false,
    required this.railWidth,
  }) : super(key: key);

  final double width;
  final double menuWidth;
  final VoidCallback onTap;
  final bool selected;
  final IconData icon;
  final String label;
  final bool showDivider;
  final double railWidth;

  // Height of the menu item.
  static const double _itemHeight = 42;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    // Just some colors for the menu items, based on the current color schemes.
    // Always when you can, use colors from the theme.colorScheme to make
    // custom elements in your app they react to theme changes and use the theme
    // colors. You can make elaborate hues and opacities of the colors in the
    // theme's color schemes, like here:
    final Color iconColor = isLight
        ? Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x99),
            theme.colorScheme.onBackground)
        : Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x99),
            theme.colorScheme.onBackground);

    final Color textColor =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.primary;

    // The M3 guide calls for 12dp padding after the selection indicator on
    // the menu highlight in a Drawer or side menu. We can do that, but we
    // have such a narrow rail for phone size, so at rail sizes we will make it
    // much smaller, even 2 different sizes.
    final double endPadding = (width > railWidth + 10)
        ? 12
        // If we use a really narrow rail rail, make padding even smaller-
        : railWidth < 60
            ? 5
            : 8;
    // Remove the menu when it gets smaller than 4dp during animation.
    if (width < 4) {
      return const SizedBox.shrink();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showDivider) const Divider(thickness: 1, height: 1),
          Padding(
            padding:
                EdgeInsetsDirectional.fromSTEB(endPadding, 2, endPadding, 2),
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              // This is a tap command menu, so we keep selected item
              // transparent. We still get desktop/web hover and tap splash.
              // However, you can do this on a menu that selects an item that
              // should remain highlighted and show last selected item:
              color: selected
                  ? theme.primaryColor.withAlpha(50)
                  : Colors.transparent,
              //color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: SizedBox(
                  height: _itemHeight,
                  width: width,
                  child: OverflowBox(
                    alignment: AlignmentDirectional.topStart,
                    minWidth: 0,
                    maxWidth: menuWidth,
                    child: Row(
                      children: <Widget>[
                        MaybeTooltip(
                          // Show tooltips only at rail size.
                          condition: width == railWidth,
                          // The item menu labels is a tooltip on rail size.
                          message: label,
                          // Just to get the tooltip outside the rail.
                          margin: const EdgeInsetsDirectional.only(start: 50),
                          // Constrain icon to min of rail width.
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 14),
                            child: Icon(icon,
                                color: selected
                                    ? iconColor
                                    : textColor.withOpacity(0.8)),
                          ),
                        ),
                        // Below width of 10dp we remove the label.
                        if (width < railWidth + 10)
                          const SizedBox.shrink()
                        else
                          Text(
                            label,
                            style: theme.textTheme.bodyLarge?.copyWith(
                                color: selected
                                    ? iconColor
                                    : textColor.withOpacity(0.8)),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

class MenuItemInfo {
  final IconData icon;
  final String label;

  /// Unique Id
  final String id;

  MenuItemInfo({
    required this.id,
    required this.icon,
    required this.label,
  });
}
