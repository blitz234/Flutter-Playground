import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/favorite_provider.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Favourites'),
        ),
        body: Consumer<FavoriteProvider>(
          builder: (context, value, child) {
            return ListView.builder(
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text('Item ${value.selectedIndex[index]}'),
                    onTap: (() {
                      value.addIndex(value.selectedIndex[index]);
                    }),
                    trailing: const Icon(Icons.favorite),
                  );
                }),
                itemCount: value.selectedIndex.length);
          },
        ));
  }
}
