import 'package:baru/utils/app_icons.dart';
import 'package:baru/widgets/category_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:baru/model/transaction.dart';
import 'package:baru/provider/transaction_provider.dart';
import 'package:baru/widgets/category_item.dart';

class NewExpensePage extends StatefulWidget {
  const NewExpensePage({super.key});

  @override
  _NewExpensePageState createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nominalController = TextEditingController();
  final _tanggalController = TextEditingController();

  DateTime? _selectedDate;
  String _selectedCategoryName = 'Pilih Kategori';
  IconData? _selectedCategoryIcon = Icons.category;
  String? _selectedCategoryAssetPath;
  Color? _selectedCategoryIconColor;

  void _showCategoryPicker() async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pilih Kategori',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: categoryIcons.length,
                  itemBuilder: (context, index) {
                    final categoryName = categoryIcons.keys.elementAt(index);
                    final categoryData = categoryIcons[categoryName]!;

                    return CategoryItem(
                      name: categoryName,
                      iconData: categoryData.iconData,
                      assetPath: categoryData.assetPath,
                      color: categoryData.color,
                      onTap: () {
                        Navigator.pop(context, {
                          'name': categoryName,
                          'data': categoryData,
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedCategoryName = result['name'];
        final categoryData = result['data'];
        _selectedCategoryIcon = categoryData.iconData;
        _selectedCategoryAssetPath = categoryData.assetPath;
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nominalController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _tanggalController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  void _simpanData() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final transactionProvider = Provider.of<TransactionProvider>(
        context,
        listen: false,
      );
      final newTransaction = Transaction(
        name: _namaController.text,
        category: _selectedCategoryName,
        amount: double.tryParse(_nominalController.text) ?? 0.0,
        date: _selectedDate!,
      );
      transactionProvider.addTransactions(newTransaction);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengeluaran berhasil disimpan!')),
      );
      Navigator.pop(context, true);
    }
  }

  bool get _isFormValid {
    return _namaController.text.isNotEmpty &&
        _nominalController.text.isNotEmpty &&
        _tanggalController.text.isNotEmpty &&
        _selectedCategoryName != 'Pilih Kategori' &&
        _selectedDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pengeluaran Baru',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pengeluaran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Nama tidak boleh kosong'
                    : null,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 20),
              CategoryInputField(
                categoryName: _selectedCategoryName,
                categoryIcon: _selectedCategoryIcon,
                categoryAssetPath: _selectedCategoryAssetPath,
                categoryIconColor: _selectedCategoryIconColor,
                onTap: _showCategoryPicker,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'Tanggal Pengeluaran',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Tanggal tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Nominal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Nominal tidak boleh kosong'
                    : null,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _simpanData : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
