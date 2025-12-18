class CurrencyFormatter {
  static String formatFromString(String? value) {
    if (value == null || value.isEmpty) return '0,00';

    final double parsed = double.tryParse(value) ?? 0.0;

    final parts = parsed.toStringAsFixed(2).split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    final buffer = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      buffer.write(integerPart[i]);

      final posFromEnd = integerPart.length - i - 1;
      if (posFromEnd > 0 && posFromEnd % 3 == 0) {
        buffer.write('.');
      }
    }

    return '${buffer.toString()},$decimalPart';
  }
}
