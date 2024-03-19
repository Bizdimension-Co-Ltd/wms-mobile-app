class BusinessPartner {
  String? cardCode;
  String? cardName;
  String? cardType;
  String? address;
  BusinessPartner({this.cardCode, this.cardName, this.cardType, this.address});

  factory BusinessPartner.fromJson(Map<String, dynamic> json) {
    return BusinessPartner(
      cardCode: json['CardCode'] ?? '',
      cardName: json['CardName'] ?? '',
      cardType: json['CartType'] ?? '',
      address: json['Address'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FirstName': cardCode,
      'LastName': cardName,
      'CardType': cardType,
      'Address': address
    };
  }

  // Additional methods for creating and updating data if needed
}
