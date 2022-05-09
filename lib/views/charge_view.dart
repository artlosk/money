import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_tracker/components/dialogs/confirm_delete_dialog.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/components/extensions/hex_color_extension.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/observables/tab_observable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../components/dialogs/charge_dialog.dart';
import '../observables/charges_observable.dart';
import 'charges_view.dart';

class ChargeView extends StatelessWidget {
  const ChargeView({Key? key, required this.category}) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final ChargesState stateCharges = Provider.of<ChargesState>(context);
    stateCharges.listChargesByCategory(
        categoryId: category.id, currentDate: stateCharges.currentDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex(category.color),
        title: Text(category.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MultiProvider(
                    providers: [
                      Provider(create: (context) => TabState()),
                      Provider(
                        create: (context) {
                          return ChargesState(userId: stateCharges.userId);
                        },
                        builder: (context, child) {
                          final ChargesState state = Provider.of<ChargesState>(context);
                          state.currentDate = stateCharges.currentDate;
                          return const ChargesView();
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
      body: Observer(
        builder: (_) {
          final charges = stateCharges.charges;
          if (charges.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: Text(
                  FlutterI18n.translate(context, 'charges.TEXT_CHARGES_EMPTY'),
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: charges.length,
            itemBuilder: (BuildContext context, int index) {
              final charge = charges[index];
              return Container(
                margin: const EdgeInsets.all(20.0),
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Slidable(
                  key: const ValueKey(1),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (value) {
                          stateCharges.currentDate = charge.createdAt;
                          showChargeDialog(
                            context: context,
                            categoryId: category.id!,
                            stateCharges: stateCharges,
                            action: ActionsDialog.update,
                            oldCharge: charge,
                            chargeId: charge.id,
                          );
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label:
                            FlutterI18n.translate(context, 'charges.TEXT_EDIT'),
                      ),
                      SlidableAction(
                        onPressed: (value) {
                          showConfirmDeleteDialog(
                              context: context,
                              stateCharges: stateCharges,
                              chargeModel: charge);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: FlutterI18n.translate(
                            context, 'charges.TEXT_DELETE'),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          charge.cost.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Visibility(
                          child: Text(
                            '${FlutterI18n.translate(context, 'charges.TEXT_TITLE_CHARGE')}: ${charge.description}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFABABAB),
                            ),
                          ),
                          visible: charge.description.isNotEmpty,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            DateFormat(
                                    'dd MMMM yyyy / hh:mm',
                                    Localizations.localeOf(context)
                                        .languageCode)
                                .format(charge.createdAt)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFABABAB),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
