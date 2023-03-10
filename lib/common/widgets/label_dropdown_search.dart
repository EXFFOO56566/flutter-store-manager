import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/constants/dimension.dart';

class LabelDropdownSearch<T> extends StatefulWidget {
  final String label;
  final String labelHint;
  final bool withAsterisk;
  final List<T> items;
  final T? selectedItem;
  final Function? onItemSelected;
  final bool readOnly;
  final bool showSearchBox;
  final double? maxHeight;
  final bool showClearButton;
  final double? height;
  const LabelDropdownSearch(
      {Key? key,
      required this.label,
      required this.labelHint,
      this.withAsterisk = true,
      required this.items,
      this.selectedItem,
      this.onItemSelected,
      this.showSearchBox = true,
      this.maxHeight,
      this.readOnly = false,
      this.showClearButton = true,
      this.height})
      : super(key: key);

  @override
  LabelDropdownSearchState createState() => LabelDropdownSearchState<T>();
}

class LabelDropdownSearchState<T> extends State<LabelDropdownSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (widget.label.isNotEmpty)
            ? RichText(
                text: TextSpan(
                    text: widget.label,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: fontSize(context, 14)),
                    children: [
                      widget.withAsterisk
                          ? TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: fontSize(context, 14)))
                          : const TextSpan()
                    ]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              )
            : const SizedBox.shrink(),
        (widget.label.isNotEmpty) ? SizedBox(height: height(context, 7)) : const SizedBox.shrink(),
        SizedBox(
          height: widget.height ?? height(context, 60),
          child: DropdownSearch<T>(
              mode: Mode.MENU,
              enabled: !widget.readOnly,
              showSelectedItems: true,
              items: widget.items as List<T>,
              showClearButton: widget.showClearButton,
              showSearchBox: widget.showSearchBox,
              maxHeight: widget.maxHeight,
              compareFn: (item, selectedItem) {
                if (item is String && selectedItem is String) {
                  return item == selectedItem;
                }
                return true;
              },
              itemAsString: (item) {
                return item.toString();
              },
              emptyBuilder: (context, searchEntry) {
                return Center(
                    child: Text(
                  "Have no data",
                  style: TextStyle(color: Colors.black, fontSize: fontSize(context, 14)),
                ));
              },
              onFind: (query) async {
                // if (widget.items is List<DictItemModel> &&
                //     query != null &&
                //     query.isNotEmpty) {
                //   List<T> rs = await (widget.items as List<DictItemModel>)
                //       .where((element) => element.itemName!.contains(query))
                //       .toList() as List<T>;
                //   return Future.value(rs);
                // }
                return [];
              },
              selectedItem: widget.selectedItem,
              dropdownSearchDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 2, bottom: 2, left: 16, right: 0),
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  hintText: widget.labelHint,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle:
                      TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: fontSize(context, 14))),
              onChanged: (value) {
                // if (widget.onItemSelected != null) {
                //   if (value is CertificateType) {
                //     widget.onItemSelected!(value.index + 1);
                //   } else {
                //     widget.onItemSelected!(value);
                //   }
                // }
              }),
        ),
        SizedBox(height: height(context, 21))
      ],
    );
  }
}
