import 'package:enzet/app/data/models/item_model.dart';

class Invoice {
  final String id;
  final String storeId;
  final List<InvoiceItem> items; // Separate model for invoice items
  final double total;
  final String code;
  final String note;
  final String receiver;
  final String sender;
  final bool qc1;
  final bool qc2;
  final bool qc3;
  final String message;
  final InvoiceStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Invoice({
    required this.id,
    required this.storeId,
    required this.items,
    required this.total,
    required this.code,
    required this.note,
    required this.receiver,
    required this.sender,
    required this.qc1,
    required this.qc2,
    required this.qc3,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      storeId: json['storeId'],
      items: List<InvoiceItem>.from(
        json['items'].map((item) => InvoiceItem.fromJson(item)),
      ),
      total: json['total'],
      code: json['code'],
      note: json['note'],
      receiver: json['receiver'],
      sender: json['sender'],
      qc1: json['qc1'],
      qc2: json['qc2'],
      qc3: json['qc3'],
      message: json['message'],
      status: InvoiceStatus.values[json['status']],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'code': code,
      'note': note,
      'receiver': receiver,
      'sender': sender,
      'qc1': qc1,
      'qc2': qc2,
      'qc3': qc3,
      'message': message,
      'status': status.value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class InvoiceItem {
  final ItemModel item;
  final int quantity;
  final double subtotal;
  final String? note;

  InvoiceItem({
    required this.item,
    required this.quantity,
    required this.subtotal,
    this.note,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      item: ItemModel.fromJson(json['item']),
      quantity: json['quantity'],
      subtotal: json['subtotal'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'quantity': quantity,
      'subtotal': subtotal,
      'note': note,
    };
  }

  InvoiceItem copyWith({
    ItemModel? item,
    int? quantity,
    double? subtotal,
    String? note,
  }) {
    return InvoiceItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
      note: note ?? this.note,
    );
  }
}

enum InvoiceStatus {
  newOrder(1),
  repeatOrder(2),
  sample(3);

  final int value;
  const InvoiceStatus(this.value);
}
