import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sidebar/src/components/shadow_card.dart';

import 'menu_item.dart';

/// App side menu and rail

class AppMenu extends StatefulWidget {
  const AppMenu({
    Key? key,
    this.title,
    required this.maxWidth,
    this.onOperate,
    this.onSelect,
    required this.railWidth,
    required this.menuItems,
    this.menuFooter,
    this.menuHeader,
    this.selectedItemId,
  }) : super(key: key);
  final Widget? title;
  final double maxWidth;
  final VoidCallback? onOperate;
  //When Menu Item Is Selected
  final ValueChanged<String>? onSelect;
  final double railWidth;
  final List<MenuItemInfo> menuItems;
  final String? selectedItemId;

  ///Widget rendered before the [SideMenuItem] list
  final Widget? menuHeader;

  ///Widget rendered after the [SideMenuItem] list
  final Widget? menuFooter;

  @override
  _AppMenuState createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  String? selectedItemId;

  @override
  void didUpdateWidget(covariant AppMenu oldWidget) {
    if (widget.selectedItemId != oldWidget.selectedItemId) {
      selectedItemId = widget.selectedItemId;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    selectedItemId = widget.selectedItemId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        // The overflow box is not the prettiest approach, but has some
        // convenient properties for this simple animated menu using just
        // a single AnimatedContainer.
        return OverflowBox(
          alignment: AlignmentDirectional.topStart,
          minWidth: 0,
          maxWidth: widget.maxWidth,
          child: ShadowCard(
            width: size.maxWidth,
            borderRadius: const BorderRadius.all(Radius.zero),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // We use an AppBar element as header in the menu too, a custom
                // Widget would be less restrictive, but for simplicity, the
                // AppBar has so many nice things built in to handle text style,
                // size and scaling for the title that are tedious to replicate
                Padding(
                  padding: kIsWeb
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: IconButton(
                            onPressed: () {
                              widget.onOperate?.call();
                            },
                            tooltip: "Menu",
                            icon: Icon(
                              Icons.menu_open,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                      ),
                      if (size.maxWidth > 150)
                        Flexible(child: widget.title ?? const SizedBox())
                    ],
                  ),
                ),
                if (widget.menuHeader != null) widget.menuHeader!,
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero, //  Removes all edge insets
                    children: <Widget>[
                      // A mock user profile on the menu/rail.
                      // _UserProfile(railWidth: widget.railWidth),
                      // Add all the menu items.

                      for (int i = 0; i < widget.menuItems.length; i++)
                        SideMenuItem(
                          width: size.maxWidth,
                          menuWidth: widget.maxWidth,
                          onTap: () {
                            setState(() {
                              selectedItemId = widget.menuItems[i].id;
                            });
                            widget.onSelect?.call(widget.menuItems[i].id);
                          },
                          selected: selectedItemId == widget.menuItems[i].id,
                          icon: widget.menuItems[i].icon,
                          label: widget.menuItems[i].label,
                          showDivider: false,
                          railWidth: widget.railWidth,
                        ),
                    ],
                  ),
                ),
                if (widget.menuFooter != null) widget.menuFooter!
              ],
            ),
          ),
        );
      },
    );
  }
}
