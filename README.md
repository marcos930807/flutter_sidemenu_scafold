<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Responsive Side Menu Scaffold

## Features



## Getting started

Replace normal Scaffold with This and add Menu.

## Usage



```dart
ResponsiveScaffold(
                key: context.read<SideBarCubit>().scaffoldKey,
                body: const AutoRouter(),
                menuTitle: Text(S.of(context).DcartAdminPanel),
                // Make Rail width larger when using it on tablet or desktop.
                railWidth: 66,
                appBar: showNab(context)
                    ? AppBar(
                        backgroundColor: Theme.of(context).cardColor,
                        elevation: 0,
                        iconTheme: Theme.of(context).iconTheme,
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_outlined,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    : null,
                menuHeader: const MenuHeader(),
                menuItems: [
                  MenuItemInfo(
                      icon: Icons.person_outline, label: S.of(context).profile),
                  MenuItemInfo(
                      icon: Icons.dashboard_outlined,
                      label: S.of(context).dashboard),
                  MenuItemInfo(
                      icon: Icons.people_alt_outlined,
                      label: S.of(context).employees),
                  MenuItemInfo(icon: Icons.tab, label: S.of(context).tables),
                  MenuItemInfo(
                      icon: Icons.restaurant_menu_rounded,
                      label: S.of(context).menu),
                  MenuItemInfo(
                      icon: Icons.shopping_cart,
                      label: S.of(context).eventItems),
                  MenuItemInfo(
                      icon: Icons.storefront,
                      label: S.of(context).businessServices),
                  MenuItemInfo(
                      icon: Icons.park_outlined,
                      label: S.of(context).dailyActivities),
                ],
                currentSelectedMenuItem: _determineIndexByRoute(
                    AutoRouter.of(context, watch: true)
                            .innerRouterOf(HomePageRoute.name)
                            ?.current
                            .name ??
                        ""),
                onSelect: (int index) {
                  switch (index) {
                    case 0:
                      _onPressedItem(context, const ProfilePageRoute());
                      break;
                    case 1:
                      _onPressedItem(context, const DashboardRoute());
                      break;
                    case 2:
                      _onPressedItem(context, const EmployeeListPageRoute());
                      break;
                    case 3:
                      _onPressedItem(
                          context, const ServingLocationManagementPageRoute());
                      break;
                    case 4:
                      _onPressedItem(context, const MenuPageRoute());
                      break;
                    case 5:
                      _onPressedItem(context, const EventItemsPageRoute());
                      break;
                    case 6:
                      _onPressedItem(context, BusinessServicesPageRoute());
                      break;
                    case 7:
                      _onPressedItem(context, const DailyActivitiesPageRoute());
                      break;

                    default:
                  }
                },
              ),
```

## Additional information

