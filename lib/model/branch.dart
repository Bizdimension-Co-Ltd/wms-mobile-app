class Branch {
  String? bPLName;
  int? bPLID = 0;

  Branch({this.bPLName, this.bPLID});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      bPLName: json['BPLName'] ?? '',
      bPLID: json['BPLID'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BPLName': bPLName,
      'bPLID': bPLID,
    };
  }

  // Additional methods for creating and updating data if needed
}
