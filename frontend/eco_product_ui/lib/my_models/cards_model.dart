class CardsModel {
  final int id;
  final String method;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  String image; 

  CardsModel({
    required this.id,
    required this.method,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.image,
  });

  factory CardsModel.fromJson(Map<String, dynamic> json) {
    // Random card image
    final cardImages = [
      "assets/images/visa.png",
      "assets/images/mastercard.png",
      "assets/images/amex.png"
    ];
    final randomImage =
        cardImages[DateTime.now().millisecond % cardImages.length];

    return CardsModel(
      id: json['id'] ?? 0,
      method: json['method'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      cardHolderName: json['cardHolderName'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      cvv: json['cvv'] ?? '',
      image: randomImage,
    );
  }
}
