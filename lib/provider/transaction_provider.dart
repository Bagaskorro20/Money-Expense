import 'package:flutter/material.dart';
import 'package:baru/database/db_helper.dart';
import 'package:baru/model/transaction.dart';
import 'package:flutter/cupertino.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;
  final DbHelper _dbHelper = DbHelper.instance;

  Future<void> fetchTransactions() async {
    _transactions = await _dbHelper.getTransactions();
    notifyListeners();
  }

  Future<void> addTransactions(Transaction newTransaction) async {
    await _dbHelper.insertTransactions(newTransaction);
    await fetchTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await _dbHelper.deleteTransactions(id);
    await fetchTransactions();
  }
}
