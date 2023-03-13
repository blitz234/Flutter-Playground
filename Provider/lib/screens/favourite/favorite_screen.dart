import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theming/providers/favorite_provider.dart';
import 'package:theming/screens/favourite/myfavorite.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Scaffold build");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Favourites'),
        actions: [
          InkWell(
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                return const MyFavoriteScreen();
              })));
            }),
            child: const Icon(Icons.favorite),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return Consumer<FavoriteProvider>(
            builder: (context, value, child) {
              debugPrint("ListTile Build");
              return ListTile(
                onTap: (() {
                  value.addIndex(index);
                }),
                title: Text('item $index'),
                trailing: Icon(
                  (value.selectedIndex.contains(index)
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_outlined),
                ),
              );
            },
          );
        }),
        itemCount: 100,
      ),
    );
  }
}
