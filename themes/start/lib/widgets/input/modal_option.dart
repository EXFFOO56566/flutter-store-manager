import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/option.dart';

class ModalOption extends StatefulWidget {
  final List<Option> options;
  final String? value;
  final ValueChanged<String> onChanged;
  final bool isExpand;
  final bool isSearch;
  final String? hintTextSearch;

  const ModalOption({
    Key? key,
    required this.options,
    required this.onChanged,
    this.value,
    this.isExpand = false,
    this.isSearch = false,
    this.hintTextSearch,
  }) : super(key: key);

  @override
  State<ModalOption> createState() => _ModalOptionState();
}

class _ModalOptionState extends State<ModalOption> {
  String _valueSearch = '';

  Widget buildView({required Widget child}) {
    if (widget.isExpand) {
      return Expanded(child: child);
    }
    return Flexible(child: child);
  }

  void changeSearch(String search) {
    setState(() {
      _valueSearch = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Option> options = _valueSearch.isEmpty
        ? widget.options
        : widget.options
            .where((element) =>
                element.key.toLowerCase().contains(_valueSearch.toLowerCase()) ||
                element.name.toLowerCase().contains(_valueSearch.toLowerCase()))
            .toList();
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isSearch)
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
              child: TextFormField(
                initialValue: _valueSearch,
                onChanged: changeSearch,
                decoration: InputDecoration(hintText: widget.hintTextSearch ?? 'Search'),
              ),
            ),
          buildView(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
              child: Column(
                children: List.generate(
                  options.length,
                  (index) {
                    Option option = options[index];
                    bool isSelect = option.key == widget.value;

                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            option.name,
                            style: theme.textTheme.bodyText2?.copyWith(color: isSelect ? theme.primaryColor : null),
                          ),
                          trailing: isSelect ? Icon(CommunityMaterialIcons.check, color: theme.primaryColor) : null,
                          contentPadding: EdgeInsets.zero,
                          onTap: () => widget.onChanged(option.key),
                        ),
                        const Divider(height: 1, thickness: 1),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
