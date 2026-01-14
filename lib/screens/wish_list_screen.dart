import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/wish.dart';
import '../utils/wish_data_loader.dart';
import '../utils/favorites_service.dart';
import '../widgets/wish_card.dart';
import 'wish_editor_screen.dart';

/// Screen displaying list of wishes for a selected category
class WishListScreen extends StatefulWidget {
  final Category category;

  const WishListScreen({super.key, required this.category});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<Wish> _wishes = [];
  Set<String> _favorites = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final wishes =
          await WishDataLoader.loadWishesByCategory(widget.category.id);
      final favorites = await FavoritesService.getFavorites();
      setState(() {
        _wishes = wishes;
        _favorites = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error loading wishes: $e');
    }
  }

  Color _parseColor(String colorHex) {
    return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
  }

  Future<void> _toggleFavorite(String wishId) async {
    final isFav = await FavoritesService.toggleFavorite(wishId);
    setState(() {
      if (isFav) {
        _favorites.add(wishId);
      } else {
        _favorites.remove(wishId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _parseColor(widget.category.color);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.category.emoji),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                widget.category.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _wishes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '😔',
                        style: const TextStyle(fontSize: 64),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'کوئی پیغام نہیں ملا',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadData,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: _wishes.length,
                      itemBuilder: (context, index) {
                        final wish = _wishes[index];
                        return WishCard(
                          wish: wish,
                          accentColor: accentColor,
                          isFavorite: _favorites.contains(wish.id),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WishEditorScreen(
                                  wish: wish,
                                  category: widget.category,
                                ),
                              ),
                            );
                            // Refresh favorites when returning
                            final favorites =
                                await FavoritesService.getFavorites();
                            setState(() => _favorites = favorites);
                          },
                          onFavoriteToggle: () => _toggleFavorite(wish.id),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
