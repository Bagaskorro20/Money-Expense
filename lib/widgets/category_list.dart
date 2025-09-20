import 'package:baru/model/transaction.dart';
import 'package:baru/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:baru/widgets/category_icon.dart';

class CategoryList extends StatelessWidget {
  final List<Transaction> transactions;

  const CategoryList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final Map<String, double> categoryTotal = {};

    for (var transaction in transactions) {
      if (transaction.date.year == now.year &&
          transaction.date.month == now.month) {
        final category = transaction.category;
        categoryTotal[category] =
            (categoryTotal[category] ?? 0) + transaction.amount;
      }
    }
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryIcons.length,
      itemBuilder: (context, index) {
        final categoryName = categoryIcons.keys.elementAt(index);
        final categoryData = categoryIcons[categoryName]!;

        final totalAmount = categoryTotal[categoryName] ?? 0.0;
        final formatAmount = currencyFormat.format(totalAmount);

        return Container(
          width: 150,
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryIcon(
                iconData: categoryData.iconData,
                assetIcon: categoryData.assetPath,
                iconColor: Colors.white,
                backgroundColor: categoryData.color,
                hasBackground: true,
              ),
              Text(
                categoryName,
                style: const TextStyle(fontSize: 14, color: Color(0xFF828282)),
              ),
              Text(
                formatAmount,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
