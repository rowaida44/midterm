import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provide.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet. Tap the heart icon to add some!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: Image.network(
                      item['image'],
                      width: 60,
                      height: 60,
                    ),
                    title: Text(
                      item['name'].toString().toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Pokémon Number: ${item['number']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        favoritesProvider.toggleFavorite(item);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}