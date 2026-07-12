import 'package:expense_tracker/repositories/expense_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/expense.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>>{
  ExpenseNotifier() :super([]){
    loadExpenses();
  }
  final _repository = ExpenseRepository();
  void loadExpenses(){
    _repository.getExpenses().listen((expenses) {
      state = expenses;
    });
  }
  void addExpense(Expense expense){
    _repository.addExpense(expense);
  }
  void deleteExpense(String id){
    _repository.deleteExpense(id);
  }

}
final expenseProvider = StateNotifierProvider<ExpenseNotifier , List<Expense>>(
        (ref) => ExpenseNotifier()
);
