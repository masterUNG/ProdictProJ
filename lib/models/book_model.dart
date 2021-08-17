import 'dart:convert';

class BookModel {
  final String BOOK_NUMBER;
  final String BOOK_DATE;
  final String BOOK_NAME;
  final String BOOK_FILE_NAME;
  BookModel({
    required this.BOOK_NUMBER,
    required this.BOOK_DATE,
    required this.BOOK_NAME,
    required this.BOOK_FILE_NAME,
  });

  BookModel copyWith({
    String? BOOK_NUMBER,
    String? BOOK_DATE,
    String? BOOK_NAME,
    String? BOOK_FILE_NAME,
  }) {
    return BookModel(
      BOOK_NUMBER: BOOK_NUMBER ?? this.BOOK_NUMBER,
      BOOK_DATE: BOOK_DATE ?? this.BOOK_DATE,
      BOOK_NAME: BOOK_NAME ?? this.BOOK_NAME,
      BOOK_FILE_NAME: BOOK_FILE_NAME ?? this.BOOK_FILE_NAME,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'BOOK_NUMBER': BOOK_NUMBER,
      'BOOK_DATE': BOOK_DATE,
      'BOOK_NAME': BOOK_NAME,
      'BOOK_FILE_NAME': BOOK_FILE_NAME,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) { 

    return BookModel(
      BOOK_NUMBER: map['BOOK_NUMBER'] == null ? '' : map['BOOK_NUMBER'],
      BOOK_DATE: map['BOOK_DATE'] == null ? '' : map['BOOK_DATE'],
      BOOK_NAME: map['BOOK_NAME'] == null ? '' : map['BOOK_NAME'],
      BOOK_FILE_NAME: map['BOOK_FILE_NAME'] == null ? '' : map['BOOK_FILE_NAME'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookModel(BOOK_NUMBER: $BOOK_NUMBER, BOOK_DATE: $BOOK_DATE, BOOK_NAME: $BOOK_NAME, BOOK_FILE_NAME: $BOOK_FILE_NAME)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookModel &&
        other.BOOK_NUMBER == BOOK_NUMBER &&
        other.BOOK_DATE == BOOK_DATE &&
        other.BOOK_NAME == BOOK_NAME &&
        other.BOOK_FILE_NAME == BOOK_FILE_NAME;
  }

  @override
  int get hashCode {
    return BOOK_NUMBER.hashCode ^
        BOOK_DATE.hashCode ^
        BOOK_NAME.hashCode ^
        BOOK_FILE_NAME.hashCode;
  }
}
