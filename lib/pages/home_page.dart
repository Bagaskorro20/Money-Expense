import 'package:baru/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:baru/model/transaction.dart';
import 'package:baru/pages/new_expense_page.dart';
import 'package:baru/provider/transaction_provider.dart';
import 'package:baru/widgets/category_list.dart';
import 'package:baru/widgets/summary_card.dart';
import 'package:baru/widgets/transaction_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).fetchTransactions();
    super.initState();
  }

  String _calculateTotalAmount(List<Transaction> transactions) {
    final total = transactions.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );
    return _currencyFormat.format(total);
  }

  String _calculateDailyAmount(List<Transaction> transactions) {
    final today = DateTime.now();
    final dailyTransactions = transactions
        .where(
          (t) =>
              t.date.year == today.year &&
              t.date.month == today.month &&
              t.date.day == today.day,
        )
        .toList();
    final total = dailyTransactions.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );
    return _currencyFormat.format(total);
  }

  Map<String, List<Transaction>> _groupTransactionsByDate(
    List<Transaction> transactions,
  ) {
    Map<String, List<Transaction>> groupedTransactions = {};
    for (var transaction in transactions) {
      String dateKey = DateFormat('yyyy-MM-dd').format(transaction.date);
      if (!groupedTransactions.containsKey(dateKey)) {
        groupedTransactions[dateKey] = [];
      }
      groupedTransactions[dateKey]!.add(transaction);
    }
    return groupedTransactions;
  }

  String _getDateHeader(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return 'Hari Ini';
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Kemarin';
    } else {
      return DateFormat('EEEE, dd MMMM yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();
    final transactions = transactionProvider.transactions;

    final totalDailyAmount = _calculateDailyAmount(transactions);
    final totalMonthlyAmount = _calculateTotalAmount(transactions);

    final groupedTransactions = _groupTransactionsByDate(transactions);
    final sortedDates = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Halo, User!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Jangan lupa catat keuanganmu setiap hari!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Pengeluaranmu\nhari ini',
                      amount: totalDailyAmount,
                      color: const Color(0xFF0A97B0),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SummaryCard(
                      title: 'Pengeluaranmu\nbulan ini',
                      amount: totalMonthlyAmount,
                      color: const Color(0xFF46B5A7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              const Text(
                'Pengeluaran berdasarkan kategori',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 140,
                child: CategoryList(transactions: transactions),
              ),
              const SizedBox(height: 30),

              if (sortedDates.isEmpty)
                const Center(child: Text('Tidak ada transaksi.'))
              else
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: sortedDates.length,
                  itemBuilder: (context, dateIndex) {
                    final dateKey = sortedDates[dateIndex];
                    final dailyTransactions = groupedTransactions[dateKey]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getDateHeader(dateKey),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dailyTransactions.length,
                          itemBuilder: (context, transactionIndex) {
                            final transaction =
                                dailyTransactions[transactionIndex];
                            final categoryData =
                                categoryIcons[transaction.category];
                            if (categoryData == null) return const SizedBox();

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TransactionTile(
                                iconData: categoryData.iconData,
                                assetIcon: categoryData.assetPath,
                                iconColor: categoryData.color,
                                title: transaction.name,
                                amount: _currencyFormat.format(
                                  transaction.amount,
                                ),
                                // onDelete: () => transactionProvider.deleteTransaction(transaction.id!),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final shouldRefresh = await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => NewExpensePage()));
          if (shouldRefresh != null && shouldRefresh) {
            transactionProvider.fetchTransactions();
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: const Color(0xFF0A97B0),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
