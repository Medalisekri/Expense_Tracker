import 'package:cloud_firestore/cloud_firestore.dart';
class Expense {
  final String id;
  final double amount;
  final String category;
  final String note;
  final DateTime date;
  final String userId;

    Expense({
    required this.id,
      required this.amount,
      required this.category,
      required this.note,
      required this.date,
      required this.userId,

});
    Map<String , dynamic> toMap() {
      return {

          'amount':amount,
        'category':category,
        'note':note,
        'date':date,
        'userId':userId,
      };
    }
    factory Expense.fromFirestore(DocumentSnapshot doc){
      final data = doc.data() as Map<String , dynamic>;
      final Timestamp timestamp = data['date'] as Timestamp;
      return Expense(
        id: doc.id,
        amount: (data['amount'] as num).toDouble(),
        category: data['category'],
        note: data['note'],
        date: timestamp.toDate(),
        userId: data['userId'],
      );
    }
    Expense copyWith({
    String? id ,
      double? amount,
      String? category,
      String? note,
      DateTime? date,
      String? userId,
}){
      return Expense(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        note: note ?? this.note,
        date: date ?? this.date,
          userId: userId ?? this.userId,
      );
    }
}
