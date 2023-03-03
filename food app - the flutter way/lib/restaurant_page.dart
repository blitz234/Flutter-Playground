import 'package:flutter/material.dart';
import 'package:login_project/components/restaurant_categories.dart';
import 'package:login_project/models/menu.dart';
import 'components/menu_card.dart';
import 'components/restaurant_info.dart';
import 'components/restuarant_appbar.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final scrollController = ScrollController();

  int selectedCategoryIndex = 0;

  double restaurantInfoHeight = 200 + 170 - kToolbarHeight;

  @override
  void initState() {
    createBreakPoints();
    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
    });
    super.initState();
  }

  void scrollToCategory(int index) {
    if (selectedCategoryIndex != index) {
      int totalItems = 0;

      for (var i = 0; i < index; i++) {
        totalItems += demoCategoryMenus[i].items.length;
      }
      scrollController.animateTo(
          restaurantInfoHeight + (116 * totalItems) + (50 * index),
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease);

      setState(() {
        selectedCategoryIndex = index;
      });
    }
  }

  // scroll to select categories
  List<double> breakPoints = [];
  void createBreakPoints() {
    double firstBreakPoint =
        restaurantInfoHeight + 50 + (116 * demoCategoryMenus[0].items.length);
    breakPoints.add(firstBreakPoint);

    for (var i = 1; i < demoCategoryMenus.length; i++) {
      double breakPoint =
          breakPoints.last + 50 + (116 * demoCategoryMenus[i].items.length);
      breakPoints.add(breakPoint);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
    for (var i = 0; i < demoCategoryMenus.length; i++) {
      if (i == 0) {
        if ((offset < breakPoints.first) & (selectedCategoryIndex != 0)) {
          setState(() {
            selectedCategoryIndex = 0;
          });
        }
      } else if ((breakPoints[i - 1] <= offset) & (offset < breakPoints[i])) {
        if (selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          const RestaurantAppBar(),
          const SliverToBoxAdapter(child: RestaurantInfo()),
          SliverPersistentHeader(
            delegate: RestaurantCategories(
              onChanged: scrollToCategory,
              selectedIndex: selectedCategoryIndex,
            ),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, categoryIndex) {
              List<Menu> items = demoCategoryMenus[categoryIndex].items;
              return MenuCategoryItem(
                title: demoCategoryMenus[categoryIndex].category,
                items: List.generate(
                    items.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: MenuCard(
                              image: items[index].image,
                              title: items[index].title,
                              price: items[index].price),
                        )),
              );
            }, childCount: demoCategoryMenus.length)),
          )
        ],
      ),
    );
  }
}
