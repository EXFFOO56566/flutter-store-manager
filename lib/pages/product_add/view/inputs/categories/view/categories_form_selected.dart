import 'package:flutter/material.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Model
import 'package:category_repository/category_repository.dart';

class CategoriesFormSelected extends StatelessWidget {
  final List<Category> categories;
  final void Function(List<Category>) onChanged;

  const CategoriesFormSelected({Key? key, required this.categories, required this.onChanged}) : super(key: key);

  List<Option> get value => categories.map((Category e) => Option(key: '${e.id}', name: '${e.name}')).toList();

  // Handle delete category
  void _delete(List<Option> data) {
    List<Category> categories = data.map((Option e) => Category(id: int.parse(e.key), name: e.name)).toList();
    onChanged(categories);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelInput(title: AppLocalizations.of(context)!.translate('product:text_Categories'), isLarge: true),
        if (categories.isNotEmpty) ...[
          InputGroupOption(
            value: value,
            onChanged: _delete,
          ),
          const SizedBox(height: 20),
        ]
      ],
    );
  }
}
