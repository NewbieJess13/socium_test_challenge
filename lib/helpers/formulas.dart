class Formulas {
  Formulas._();
  static double calculateDiscount(double discountPercentage, int price) {
    final discountedAmount = (price / 100 * discountPercentage).roundToDouble();
    double discountedPrice = price - discountedAmount;
    return discountedPrice;
  }
}
