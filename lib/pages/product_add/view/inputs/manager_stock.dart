import 'package:flutter/cupertino.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../../bloc/product_add_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class ProductManagerStock extends StatelessWidget {
  static const List<String> visible = ['simple', 'variable'];

  const ProductManagerStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.managerStock != current.managerStock,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: LabelInput(
                title: AppLocalizations.of(context)!.translate('product:text_manager_stock'),
                padding: EdgeInsets.zero,
              ),
            ),
            CupertinoSwitch(
              value: state.managerStock.value,
              onChanged: (value) => context.read<ProductAddBloc>().add(ManagerStockChanged(value)),
            )
          ],
        );
      },
    );
  }
}
