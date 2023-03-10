import 'package:flutter/material.dart';
import 'package:ui/models/option.dart';

import '../input/input_search_field.dart';

import 'button_footer.dart';
import 'list_option_multi.dart';
import 'modal_option_container.dart';

List<Option> _dataSearch({required List<Option> data, String search = ''}) {
  if (data.isEmpty || search.isEmpty) {
    return data;
  }
  final textSearch = search.toLowerCase();
  List<Option> result = <Option>[];

  for (Option option in data) {
    final List<Option> childOptions = flattenOption(data: option.options ?? []);
    bool checkName = option.key.toLowerCase().contains(textSearch) || option.name.toLowerCase().contains(textSearch);
    bool checkChild = childOptions.indexWhere((element) =>
            element.key.toLowerCase().contains(textSearch) || element.name.toLowerCase().contains(textSearch)) >
        -1;
    if (checkName || checkChild) {
      result.add(
        Option(
          key: option.key,
          name: option.name,
          options: _dataSearch(data: childOptions, search: search),
        ),
      );
    }
  }
  return result;
}

class ModalOptionMultiFooterView extends StatefulWidget {
  final List<Option> options;
  final List<Option> value;
  final bool isExpand;
  final bool isSearch;
  final String? hintTextSearch;
  final String? textButtonBottom;
  final ValueChanged<List<Option>?> onPressButton;
  final String? textSecondaryButton;
  final ValueChanged<List<Option>?>? onPressSecondaryButton;
  final bool isItemSelectAll;
  final String? textItemSelectAll;

  const ModalOptionMultiFooterView({
    Key? key,
    required this.options,
    this.value = const [],
    this.isExpand = false,
    this.isSearch = false,
    this.hintTextSearch,
    this.textButtonBottom,
    required this.onPressButton,
    this.textSecondaryButton,
    this.onPressSecondaryButton,
    this.isItemSelectAll = false,
    this.textItemSelectAll,
  })  : assert(options.length > 0),
        super(key: key);

  @override
  State<ModalOptionMultiFooterView> createState() => _ModalOptionMultiFooterViewState();
}

class _ModalOptionMultiFooterViewState extends State<ModalOptionMultiFooterView> {
  String _valueSearch = '';
  late List<Option> _value;

  @override
  void initState() {
    _value = [...widget.value];
    super.initState();
  }

  void changeSearch(String search) {
    setState(() {
      _valueSearch = search;
    });
  }

  void changeValue(Option value) {
    setState(() {
      int visit = _value.indexWhere((element) => element.key == value.key);
      bool isSelect = visit > -1;
      if (isSelect) {
        _value.removeAt(visit);
      } else {
        _value.add(Option(key: value.key, name: value.name));
      }
    });
  }

  List<Option> getSelectOptionAll() {
    return flattenOption(data: [...widget.options]).length == _value.length ? const [Option(key: 'all', name: '')] : [];
  }

  void changeSelectAll(bool isAddSelect) {
    setState(() {
      _value.clear();
      if (isAddSelect) {
        _value.addAll(
          flattenOption(data: [...widget.options]),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    late List<Option> options = _dataSearch(data: [...widget.options], search: _valueSearch);
    late List<Option> selectOptionAll = getSelectOptionAll();
    return ModalOptionContainer(
      search: widget.isSearch
          ? Padding(
              padding: const EdgeInsets.fromLTRB(25, 17, 25, 5),
              child: InputSearchField(
                initialValue: _valueSearch,
                onChanged: changeSearch,
                hintText: widget.hintTextSearch,
              ),
            )
          : null,
      isExpand: widget.isExpand,
      footer: ButtonFooter(
        text: widget.textButtonBottom ?? 'Apply',
        onPressedText: () => widget.onPressButton(_value),
        textSecondary: widget.textSecondaryButton,
        onPressedTextSecondary:
            widget.onPressSecondaryButton != null ? () => widget.onPressSecondaryButton!.call(_value) : null,
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
      ),
      padding: const EdgeInsets.only(top: 15),
      child: ListOptionMulti(
        data: options,
        keysSelected: _value,
        clickSelect: changeValue,
        padding: const EdgeInsets.fromLTRB(25, 19, 25, 25),
        heading: widget.isItemSelectAll
            // ? Text('sss')
            ? ItemOption(
                option: Option(key: 'all', name: widget.textItemSelectAll ?? 'Select All'),
                onClick: (_) => changeSelectAll(selectOptionAll.isEmpty),
                selectOptions: selectOptionAll,
              )
            : null,
      ),
    );
  }
}
