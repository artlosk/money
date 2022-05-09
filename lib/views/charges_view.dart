import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/components/bottom_bar.dart';
import 'package:money_tracker/components/dialogs/category_dialog.dart';
import 'package:money_tracker/components/dialogs/charge_dialog.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/models/hybrid_model.dart';
import 'package:money_tracker/observables/charges_observable.dart';
import 'package:money_tracker/views/loading_view.dart';
import 'package:provider/provider.dart';
import '../components/dialogs/confirm_delete_dialog.dart';
import 'package:money_tracker/components/extensions/hex_color_extension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../observables/tab_observable.dart';
import 'charge_view.dart';

class ChargesView extends StatelessWidget {
  const ChargesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TabState stateTab = Provider.of<TabState>(context);
    final ChargesState stateCharges = Provider.of<ChargesState>(context);
    stateCharges.getCategories();
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: TextButton(
              onPressed: () => stateCharges.selectDate(context),
              child: Center(
                child: Text(
                  DateFormat('LLLL yyyy',
                          Localizations.localeOf(context).languageCode)
                      .format(stateCharges.currentDate)
                      .toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showCategoryDialog(
                      context: context,
                      stateCharges: stateCharges,
                      action: ActionsDialog.create,
                    );
                  },
                  icon: const Icon(Icons.add)),
            ],
          ),
          body: Observer(builder: (_) {
            final categories = stateCharges.categories;
            final double totalCost = categories.fold(0, (previousValue, HybridModel element) => previousValue! + element.cost) ?? 0;

            return stateCharges.isLoading ? const LoadingView() : Column(
              children: [
                Expanded(
                  child: totalCost == 0
                      ? Container(
                          color: const Color(0xFFD0D0D0),
                          child: Center(
                            child: Text(
                              'За ${DateFormat('LLLL', Localizations.localeOf(context).languageCode).format(stateCharges.currentDate).toString()} нет расходов',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      : SfCircularChart(
                          series: <CircularSeries>[
                            DoughnutSeries<HybridModel, String>(
                                dataSource: categories,
                                pointColorMapper: (HybridModel data, _) =>
                                    HexColor.fromHex(data.category.color),
                                xValueMapper: (HybridModel data, _) =>
                                    data.category.title,
                                yValueMapper: (HybridModel data, _) =>
                                    data.cost,
                                dataLabelSettings:
                                    const DataLabelSettings(
                                        showZeroValue: false,
                                        isVisible: true,
                                        textStyle:
                                            TextStyle(fontSize: 18)),
                                dataLabelMapper: (HybridModel data, _) =>
                                    data.category.title,
                                animationDuration: 500),
                          ],
                        ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories[index];
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(20.0),
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
                                    showCategoryDialog(
                                      context: context,
                                      stateCharges: stateCharges,
                                      action: ActionsDialog.update,
                                      category: category.category,
                                    );
                                  },
                                  backgroundColor: const Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: FlutterI18n.translate(
                                      context, 'charges.TEXT_EDIT'),
                                ),
                                SlidableAction(
                                  onPressed: (value) {
                                    showConfirmDeleteDialog(
                                        context: context,
                                        stateCharges: stateCharges,
                                        categoryId: category.category.id);
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category.category.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0),
                                        child: Text(
                                          '${FlutterI18n.translate(context, 'charges.TEXT_TOTAL')}: ${category.cost}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFABABAB),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: HexColor.fromHex(category.category.color),
                                      size: 30.0,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return Provider(
                                                create: (context) => ChargesState(userId: stateCharges.userId),
                                                builder: (context, child) {
                                                  final ChargesState state = Provider.of<ChargesState>(context);
                                                  state.currentDate = stateCharges.currentDate;
                                                  return ChargeView(category: category.category);
                                                },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          showChargeDialog(
                              context: context,
                              categoryId: category.category.id!,
                              stateCharges: stateCharges,
                              //chargeDate: stateCharges.currentDate,
                              action: ActionsDialog.create,
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            );
          }),
          // }),
          // body: StreamBuilder<List<HybridModel>>(
          //   stream: stateCharges.getCatWithTotal(
          //       currentDate: stateCharges.currentDate),
          //   initialData: const [],
          //   builder: (BuildContext context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const LoadingView();
          //     } else if (snapshot.hasError) {
          //       return Center(child: Text(snapshot.error.toString()));
          //     }
          //
          //     final categories = snapshot.data;
          //     final double totalCost = categories?.fold(
          //             0,
          //             (previousValue, HybridModel element) =>
          //                 previousValue! + element.cost) ??
          //         0;
          //
          //     return Column(
          //       children: [
          //         Expanded(
          //           child: totalCost == 0
          //               ? Container(
          //                   color: const Color(0xFFD0D0D0),
          //                   child: Center(
          //                     child: Text(
          //                       'За ${DateFormat('LLLL', Localizations.localeOf(context).languageCode).format(stateCharges.currentDate).toString()} нет расходов',
          //                       style: const TextStyle(fontSize: 16),
          //                     ),
          //                   ),
          //                 )
          //               : SfCircularChart(
          //                   series: <CircularSeries>[
          //                     DoughnutSeries<HybridModel, String>(
          //                         dataSource: snapshot.data,
          //                         pointColorMapper: (HybridModel data, _) =>
          //                             HexColor.fromHex(data.category.color),
          //                         xValueMapper: (HybridModel data, _) =>
          //                             data.category.title,
          //                         yValueMapper: (HybridModel data, _) =>
          //                             data.cost,
          //                         dataLabelSettings: const DataLabelSettings(
          //                             showZeroValue: false,
          //                             isVisible: true,
          //                             textStyle: TextStyle(fontSize: 18)),
          //                         dataLabelMapper: (HybridModel data, _) =>
          //                             data.category.title,
          //                         animationDuration: 500),
          //                   ],
          //                 ),
          //         ),
          //         Expanded(
          //           child: ListView.builder(
          //             itemCount: categories!.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               final category = categories[index];
          //               return GestureDetector(
          //                 child: Container(
          //                   margin: const EdgeInsets.all(20.0),
          //                   decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius: const BorderRadius.all(
          //                       Radius.circular(10.0),
          //                     ),
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.grey.withOpacity(0.3),
          //                         spreadRadius: 5,
          //                         blurRadius: 7,
          //                         offset: const Offset(0, 5),
          //                       ),
          //                     ],
          //                   ),
          //                   child: Slidable(
          //                     key: const ValueKey(1),
          //                     endActionPane: ActionPane(
          //                       motion: const ScrollMotion(),
          //                       children: [
          //                         SlidableAction(
          //                           onPressed: (value) {
          //                             showCategoryDialog(
          //                               context: context,
          //                               stateCharges: stateCharges,
          //                               action: ActionsDialog.update,
          //                               category: category.category,
          //                             );
          //                           },
          //                           backgroundColor: const Color(0xFF21B7CA),
          //                           foregroundColor: Colors.white,
          //                           icon: Icons.edit,
          //                           label: FlutterI18n.translate(context, 'charges.TEXT_EDIT'),
          //                         ),
          //                         SlidableAction(
          //                           onPressed: (value) {
          //                             showConfirmDeleteDialog(
          //                                 context: context,
          //                                 stateCharges: stateCharges,
          //                                 categoryUid: category.category.id);
          //                           },
          //                           backgroundColor: const Color(0xFFFE4A49),
          //                           foregroundColor: Colors.white,
          //                           icon: Icons.delete,
          //                           label: FlutterI18n.translate(context, 'charges.TEXT_DELETE'),
          //                         ),
          //                       ],
          //                     ),
          //
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(20.0),
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Text(
          //                                 category.category.title,
          //                                 style: const TextStyle(
          //                                   fontSize: 18,
          //                                   fontWeight: FontWeight.w400,
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding:
          //                                     const EdgeInsets.only(top: 3.0),
          //                                 child: Text(
          //                                   '${FlutterI18n.translate(context, 'charges.TEXT_TOTAL')}: ${category.cost}',
          //                                   style: const TextStyle(
          //                                     fontSize: 14,
          //                                     color: Color(0xFFABABAB),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           IconButton(
          //                             icon: Icon(
          //                               Icons.arrow_forward_ios_sharp,
          //                               color: HexColor.fromHex(
          //                                   category.category.color),
          //                               size: 30.0,
          //                             ),
          //                             onPressed: () {
          //                               Navigator.of(context).push(
          //                                 MaterialPageRoute(
          //                                   builder: (BuildContext context) {
          //                                     return Provider(
          //                                       create: (context) => ChargesState(userId: stateCharges.userId),
          //                                       builder: (context, child) {
          //                                         final ChargesState state = Provider.of<ChargesState>(context);
          //                                         state.currentDate = stateCharges.currentDate;
          //                                         return ChargeView(category: category.category);
          //                                       }
          //                                     );
          //                                   },
          //                                 ),
          //                               );
          //                             },
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 onTap: () {
          //                   showChargeDialog(
          //                       context: context,
          //                       categoryUid: category.category.id,
          //                       stateCharges: stateCharges,
          //                       //chargeDate: stateCharges.currentDate,
          //                       action: ActionsDialog.create);
          //                 },
          //               );
          //             },
          //           ),
          //         )
          //       ],
          //     );
          //   },
          // ),
          bottomNavigationBar: Observer(
            builder: (context) => BottomBar(
              activeTabIndex: stateTab.activeTabIndex,
              onClicked: stateTab.updateTab,
            ),
          ),
        );
      },
    );
  }
}
