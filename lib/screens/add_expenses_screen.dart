import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class AddExpensesScreen extends ConsumerStatefulWidget {
  final Expense? expense;
  const AddExpensesScreen({super.key , this.expense});

  @override
  ConsumerState<AddExpensesScreen> createState() => _AddExpensesScreenState();
}
class _AddExpensesScreenState extends ConsumerState<AddExpensesScreen> {
  String? item = 'Food';
    final _noteController = TextEditingController();
  final _amountController = TextEditingController();
  final DateTime date = DateTime.now();
  final List<String> categories = ['Food' , 'Health' , 'Shopping' , 'Transport' , 'Other'];
  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    if(widget.expense!=null){
      _amountController.text = widget.expense!.amount.toString();
      _noteController.text = widget.expense!.note;
      item = widget.expense!.category;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body:Container(
        height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white54 , Colors.indigoAccent , Colors.white12])
          ),
          child:
          SafeArea(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(widget.expense!=null ? 'Edit Expense':'Add Expense' ,
            style: TextStyle(fontSize: 20) ,),
          const SizedBox(height: 40,),
   Container(
     padding: EdgeInsets.all(20),
     margin: EdgeInsets.all(10),
     decoration: BoxDecoration(
       color: Colors.white.withValues(alpha: 0.2),
       border: Border.all(color: Colors.black),
       borderRadius: BorderRadius.circular(20),
     ),
     child:
   Column(

      children: [
          TextField(
            style: TextStyle(color: Colors.white),

            decoration: InputDecoration(

              label: Text('Amount' ,
                  
                style: TextStyle(color: Colors.white),),
              
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),

              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              )
            ),

            controller: _amountController,
          ),
          const SizedBox(height: 25,),
          TextField(controller: _noteController,
            style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            label: Text('Note' , style: TextStyle(color: Colors.white),),
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),

              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              )
          ),
          ),
          const SizedBox(height: 30,),
          Container(
              margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20)
            ),
            child:
                DropdownButtonHideUnderline(child:
          DropdownButton<String>(
            padding: EdgeInsets.all(5),

            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            dropdownColor: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
            value: item,
              onChanged: (String? newValue) {
                setState(() {
                 item = newValue;
                });
              },
            items: [
              for(String item in categories)
                DropdownMenuItem(
                value: item,
                  child:
                  Text(item),)
            ], hint: Text('Category'),
          ),)),
          SizedBox(width: double.infinity,
            child:
         ElevatedButton(onPressed: (){
            final String noteInput = _noteController.text.trim();
            final double? amountInput = double.tryParse(_amountController.text.trim());
            final DateTime dateInput = date;
           if (noteInput.isEmpty || amountInput==null){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content:Text('Fill the form' ,
               style: TextStyle(color: Colors.black) ,)));
             return ;
           }
           if(amountInput<=0|| amountInput.isNegative){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter a valid amount' ,
               style: TextStyle(color: Colors.red) ,),));
             return;
           }
            if(noteInput.length>100){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note is too long' ,
                style: TextStyle(color: Colors.red) ,),));
              return;
            }
            final newExpense = Expense(
                id:widget.expense?.id ?? '', amount: amountInput, category: item ?? 'Other', note: noteInput, date: dateInput , userId: '');

            if(widget.expense!=null){
              ref.read(expenseProvider.notifier).updateExpense(newExpense);
            }else{
              ref.read(expenseProvider.notifier).addExpense(newExpense);
            }
           Navigator.pop(context);
             },
             style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
               padding: EdgeInsets.symmetric(vertical: 10)
             ),
              child: Text('Add' , style: TextStyle(color: Colors.white),)))
        ],
      ),)
            ],
      )))
      );
  }
}
