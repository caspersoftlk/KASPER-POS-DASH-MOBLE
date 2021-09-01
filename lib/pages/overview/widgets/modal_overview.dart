import 'dart:convert';

class OverViewModal {
  String liveSales;
  String hourlyRev;
  String subCatTable;
  OverViewModal({
    required this.liveSales,
    required this.hourlyRev,
    required this.subCatTable,
  });

  OverViewModal copyWith({
    String? liveSales,
    String? hourlyRev,
    String? subCatTable,
  }) {
    return OverViewModal(
      liveSales: liveSales ?? this.liveSales,
      hourlyRev: hourlyRev ?? this.hourlyRev,
      subCatTable: subCatTable ?? this.subCatTable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'liveSales': liveSales,
      'hourlyRev': hourlyRev,
      'subCatTable': subCatTable,
    };
  }

  factory OverViewModal.fromMap(Map<String, dynamic> map) {
    return OverViewModal(
      liveSales: map['liveSales'],
      hourlyRev: map['hourlyRev'],
      subCatTable: map['subCatTable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OverViewModal.fromJson(String source) =>
      OverViewModal.fromMap(json.decode(source));

  @override
  String toString() =>
      'OverViewModal(liveSales: $liveSales, hourlyRev: $hourlyRev, subCatTable: $subCatTable)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OverViewModal &&
        other.liveSales == liveSales &&
        other.hourlyRev == hourlyRev &&
        other.subCatTable == subCatTable;
  }

  @override
  int get hashCode =>
      liveSales.hashCode ^ hourlyRev.hashCode ^ subCatTable.hashCode;
}
