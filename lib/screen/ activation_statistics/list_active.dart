import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:flutter/material.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';

import '../../model/list_active_model.dart';

// ignore: must_be_immutable
class ListActivate extends StatelessWidget {
  ListActivate({super.key, required this.titles, required this.DOITAC});
  final List<ListDataActive> titles;
  bool DOITAC;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                DataTable(
                    border: const TableBorder(verticalInside: BorderSide(color: AppColors.grey)),
                    columnSpacing: 30,
                    headingTextStyle: const TextStyle(color: AppColors.primary),
                    columns: <DataColumn>[
                      const DataColumn(
                          label: Text(
                        "STT",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        "NGÀY KH",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        "SẢN PHẨM",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        "MODEL",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        "MÃ KH",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        "SERIAL",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      if (DOITAC) ...{
                        const DataColumn(
                            label: Text(
                          "KÍCH HOẠT",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const DataColumn(
                            label: Text(
                          "TÍCH ĐIỂM",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      },
                    ],
                    rows: titles
                        .map((e) => DataRow(
                                color: MaterialStateColor.resolveWith((states) {
                                  return titles.indexOf(e) % 2 != 0 ? AppColors.primary.withOpacity(0.06) : Colors.white;
                                }),
                                cells: <DataCell>[
                                  DataCell(Text((titles.indexOf(e) + 1).toString())),
                                  DataCell(Text(e.createDate.toString())),
                                  DataCell(Text(e.categoryName.toString())),
                                  DataCell(Text(e.modelName.toString())),
                                  DataCell(Text(e.id.toString())),
                                  DataCell(Text(e.serial.toString())),
                                  if (DOITAC) ...{
                                    DataCell(Text(Utils.moneyFormat(double.parse(e.price.toString())))),
                                    DataCell(Text(e.status.toString()))
                                  },
                                ]))
                        .toList()),
              ],
            )));
  }
}
