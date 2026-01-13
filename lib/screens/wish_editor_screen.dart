import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/category.dart';
import '../models/wish.dart';
import '../theme/app_colors.dart';
import '../utils/image_saver.dart';
import '../utils/favorites_service.dart';
import '../widgets/wish_preview.dart';
import '../widgets/font_selector.dart';
import '../widgets/background_selector.dart';

/// Wish editor screen for customizing text, font, color, and background
class WishEditorScreen extends StatefulWidget {
  final Wish wish;
  final Category category;

  const WishEditorScreen({
    super.key,
    required this.wish,
    required this.category,
  });

  @override
  State<WishEditorScreen> createState() => _WishEditorScreenState();
}

class _WishEditorScreenState extends State<WishEditorScreen> {
  late TextEditingController _textController;
  final GlobalKey _repaintBoundaryKey = GlobalKey();
  
  int _selectedFontIndex = 0;
  Color _textColor = AppColors.textPrimary;
  int _selectedGradientIndex = 0;
  int _selectedSolidIndex = -1;
  String? _customImagePath;
  double _fontSize = 22;
  bool _isFavorite = false;
  bool _isSaving = false;

  final List<String> _quickEmojis = ['🎂', '🎈', '🎁', '🎉', '✨', '💖', '🌟', '🥳'];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.wish.text);
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final isFav = await FavoritesService.isFavorite(widget.wish.id);
    setState(() => _isFavorite = isFav);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _textColor,
            onColorChanged: (color) {
              setState(() => _textColor = color);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showBackgroundSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackgroundSelector(
        selectedGradientIndex: _selectedGradientIndex,
        selectedSolidIndex: _selectedSolidIndex,
        customImagePath: _customImagePath,
        onGradientSelected: (index) {
          setState(() {
            _selectedGradientIndex = index;
            _selectedSolidIndex = -1;
            _customImagePath = null;
          });
          Navigator.pop(context);
        },
        onSolidSelected: (index) {
          setState(() {
            _selectedSolidIndex = index;
            _selectedGradientIndex = -1;
            _customImagePath = null;
          });
          Navigator.pop(context);
        },
        onImageSelected: (path) {
          setState(() {
            _customImagePath = path;
            _selectedGradientIndex = -1;
            _selectedSolidIndex = -1;
          });
        },
      ),
    );
  }

  Future<void> _saveImage() async {
    setState(() => _isSaving = true);

    try {
      final success = await ImageSaver.captureAndSave(_repaintBoundaryKey);
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Text(success
                  ? 'Image saved to gallery! 🎉'
                  : 'Failed to save image'),
            ],
          ),
          backgroundColor: success ? AppColors.success : AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _shareImage() async {
    await ImageSaver.captureAndShare(
      _repaintBoundaryKey,
      text: 'Check out this birthday wish! 🎂✨',
    );
  }

  Future<void> _toggleFavorite() async {
    final isFav = await FavoritesService.toggleFavorite(widget.wish.id);
    setState(() => _isFavorite = isFav);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFav ? 'Added to favorites ❤️' : 'Removed from favorites'),
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
        title: const Text('Customize Wish'),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareImage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview
            WishPreview(
              repaintBoundaryKey: _repaintBoundaryKey,
              text: _textController.text,
              fontIndex: _selectedFontIndex,
              textColor: _textColor,
              gradientIndex: _selectedGradientIndex,
              solidIndex: _selectedSolidIndex,
              customImagePath: _customImagePath,
              fontSize: _fontSize,
            ),
            const SizedBox(height: 24),

            // Text Editor
            Text(
              'Edit Text',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              maxLines: 4,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Enter your birthday wish...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Quick Emojis
            Wrap(
              spacing: 8,
              children: _quickEmojis.map((emoji) {
                return ActionChip(
                  label: Text(emoji, style: const TextStyle(fontSize: 20)),
                  backgroundColor: AppColors.surfaceVariant,
                  onPressed: () {
                    _textController.text = _textController.text + emoji;
                    _textController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _textController.text.length),
                    );
                    setState(() {});
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Font Selector
            Text(
              'Font Style',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            FontSelector(
              selectedIndex: _selectedFontIndex,
              onFontSelected: (index) {
                setState(() => _selectedFontIndex = index);
              },
            ),
            const SizedBox(height: 24),

            // Text Size & Color Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Text Size',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: _fontSize,
                        min: 14,
                        max: 42,
                        divisions: 14,
                        label: '${_fontSize.round()}',
                        onChanged: (value) {
                          setState(() => _fontSize = value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Color',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _showColorPicker,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _textColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: _textColor.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.colorize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Background Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showBackgroundSelector,
                icon: const Icon(Icons.image),
                label: const Text('Change Background'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Download Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSaving ? null : _saveImage,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.download),
                label: Text(_isSaving ? 'Saving...' : 'Download to Gallery'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
