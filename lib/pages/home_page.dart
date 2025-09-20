import 'package:baru/model/transaction.dart';
import 'package:baru/pages/new_expense_page.dart';
import 'package:baru/provider/transaction_provider.dart';
import 'package:baru/utils/custom_icon.dart';
import 'package:baru/widgets/category_list.dart';
import 'package:baru/widgets/summary_card.dart';
import 'package:baru/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
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

  //total pengeluaran
  String _calculateTotalAmount(List<Transaction> transactions) {
    final total = transactions.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );
    return _currencyFormat.format(total);
  }

  //total pengeluaran hari ini
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

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();
    final transactions = transactionProvider.transactions;

    final totalDailyAmount = _calculateDailyAmount(transactions);
    final totalMountAmount = _calculateTotalAmount(transactions);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                      color: Color(0xFF5669FF),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SummaryCard(
                      title: 'Pengeluaranmu\nbulan ini',
                      amount: totalMountAmount,
                      color: Color(0xFF26B69E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Pengeluaran berdasarkan kategori',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 130,
                child: CategoryList(transactions: transactions),
              ),
              const SizedBox(height: 30),
              const Text(
                'Hari ini',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              if (transactions.isEmpty)
                const Center(child: Text('Tidak ada transaksi hari ini.'))
              else
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    final iconData =
                        categoryIcons[transaction.category]?.icon ??
                        Icons.error;
                    final iconColor =
                        categoryIcons[transaction.category]?.color ??
                        Colors.grey;

                    return TransactionTile(
                      icon: iconData,
                      iconColor: iconColor,
                      title: transaction.name,
                      amount: 'Rp. ${transaction.amount.toStringAsFixed(0)}',
                      onDelete: () => transactionProvider.deleteTransaction(
                        transaction.id!,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final shouldRefresh = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NewExpensePage()),
          );

          // Perbarui data jika halaman kembali dengan nilai `true`
          if (shouldRefresh != null && shouldRefresh) {
            transactionProvider.fetchTransactions();
          }
        },
        backgroundColor: const Color(0xFF5669FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
