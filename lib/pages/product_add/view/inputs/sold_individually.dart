import 'package:flutter/cupertino.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../../bloc/product_add_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class ProductSoldIndividually extends StatelessWidget {
  static const List<String> visible = ['simple', 'variable'];

  const ProductSoldIndividually({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.soldIndividually != current.soldIndividually,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: LabelInput(
                title: AppLocalizations.of(context)!.translate('product:text_sold_individually'),
                padding: EdgeInsets.zero,
              ),
            ),
            CupertinoSwitch(
              value: state.soldIndividually.value,
              onChanged: (value) => context.read<ProductAddBloc>().add(SoldIndividuallyChanged(value)),
            )
          ],
        );
      },
    );
  }
}
