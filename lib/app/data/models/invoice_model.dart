class Invoice {
  final String id;
  final String storeId;
  final List<InvoiceItem> items; // Separate model for invoice items
  final double total;
  final String code;
  final String note;
  final String receiver;
  final String sender;
  final String qc1;
  final String qc2;
  final String qc3;
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
  final String itemId;
  final int quantity;
  final double price;
  final double subtotal;
  final String? note;

  InvoiceItem({
    required this.itemId,
    required this.quantity,
    required this.price,
    required this.subtotal,
    this.note,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      itemId: json['itemId'],
      quantity: json['quantity'],
      price: json['price'],
      subtotal: json['subtotal'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'quantity': quantity,
      'price': price,
      'subtotal': subtotal,
      'note': note,
    };
  }
}

enum InvoiceStatus {
  draft(1),
  pending(2),
  completed(3);

  final int value;
  const InvoiceStatus(this.value);
}
