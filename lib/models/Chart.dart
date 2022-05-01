class Chart {
  final String titleCategory;
  final String date;
  double value;
  final int colorCategory;

  Chart(this.titleCategory, this.date, this.value, this.colorCategory);

  Map<String, dynamic> toMap() {
    return {
      'titleCategory': titleCategory,
      'date': date,
      'value': value,
      'colorCategory': colorCategory
    };
  }

  factory Chart.fromDb(Map<String, dynamic> map) {
    return Chart(
        map['titleCategory'], map['date'], map['value'], map['colorCategory']);
  }
}
