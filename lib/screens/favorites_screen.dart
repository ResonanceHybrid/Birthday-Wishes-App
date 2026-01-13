import 'package:flutter/material.dart';
import '../models/wish.dart';
import '../theme/app_colors.dart';
import '../utils/wish_data_loader.dart';
import '../utils/favorites_service.dart';
import '../widgets/wish_card.dart';
import 'wish_editor_screen.dart';

/// Screen displaying user's favorite wishes
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Wish> _favoriteWishes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final favoriteIds = await FavoritesService.getFavorites();
      final allWishes = await WishDataLoader.loadAllWishes();
      final categories = await WishDataLoader.loadCategories();

      final favorites = allWishes
          .where((wish) => favoriteIds.contains(wish.id))
          .toList();

      setState(() {
        _favoriteWishes = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<void> _removeFavorite(String wishId) async {
    await FavoritesService.removeFavorite(wishId);
    setState(() {
      _favoriteWishes.removeWhere((wish) => wish.id == wishId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Removed from favorites'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.favorite, color: Colors.red),
            SizedBox(width: 8),
            Text('Favorites'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteWishes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No favorites yet',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap the ❤️ icon on any wish to save it here',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadFavorites,
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
                      itemCount: _favoriteWishes.length,
                      itemBuilder: (context, index) {
                        final wish = _favoriteWishes[index];
                        return WishCard(
                          wish: wish,
                          accentColor: AppColors.romantic,
                          isFavorite: true,
                          onTap: () async {
                            final category = await WishDataLoader.getCategoryById(
                                wish.categoryId);
                            if (category != null && mounted) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WishEditorScreen(
                                    wish: wish,
                                    category: category,
                                  ),
                                ),
                              );
                              _loadFavorites();
                            }
                          },
                          onFavoriteToggle: () => _removeFavorite(wish.id),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
