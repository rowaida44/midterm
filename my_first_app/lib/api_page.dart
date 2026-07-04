import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'provide.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  bool isLoading = true;
  String errorMessage = '';
  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse('https://openlibrary.org/search.json?q=study&limit=20'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load books');
      }

      final data = jsonDecode(response.body);
      final items = data['docs'] as List;

      final loadedBooks = items.map<Map<String, dynamic>>((book) {
        final coverId = book['cover_i'];

        return {
          'name': book['title'] ?? 'No Title',
          'author': book['author_name'] != null
              ? (book['author_name'] as List).join(', ')
              : 'Unknown Author',
          'year': book['first_publish_year']?.toString() ?? 'Unknown Year',
          'image': coverId != null
              ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
              : 'https://covers.openlibrary.org/b/id/240726-M.jpg',
        };
      }).toList();

      setState(() {
        books = loadedBooks;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load books. Please try again.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Books API')),
        body: Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 198, 243),
        title: const Text('Study Books'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final item = books[index];
          final isFav = favoritesProvider.isFavorite(item);

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 4,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item['image'],
                  width: 55,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                item['name'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Author: ${item['author']}\nYear: ${item['year']}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey,
                ),
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