class DirectPutAway {
  String? cardCode;
  String? cardName;
  int? docNum;
  String? docDate;
  String? docDueDate;
  String? taxDate;
  String? utlgr;
  int? contactPersonCode;
  String? numAtCard;
  int? bPLIDAssignedToInvoice;
  int? utlgrremp;
  String? utlwhsdesc;
  String? comments;
  String? documentStatus;
  String? journalMemo;
  String? address2;
  String? address;
  List<DocumentLine>? documentLines;

  DirectPutAway({
    this.cardCode,
    this.cardName,
    this.docNum = 0,
    this.docDueDate,
    this.contactPersonCode,
    this.numAtCard,
    this.utlgrremp,
    this.bPLIDAssignedToInvoice,
    this.utlwhsdesc,
    this.comments,
    this.documentStatus,
    this.docDate,
    this.taxDate,
    this.utlgr,
    this.journalMemo,
    this.address2,
    this.address,
    this.documentLines,
  });

  factory DirectPutAway.fromJson(Map<String, dynamic> json) {
    return DirectPutAway(
      cardCode: json['CardCode'] ?? '',
      cardName: json['CardName'] ?? '',
      docNum: json['DocNum'] ?? '',
      docDate: json['DocDate'] ?? '',
      docDueDate: json['DocDueDate'] ?? '',
      taxDate: json['TaxDate'],
      utlgr: json['U_tl_gr'],
      contactPersonCode: json['ContactPersonCode'] ?? 0,
      numAtCard: json['NumAtCard'] ?? '',
      bPLIDAssignedToInvoice: json['BPL_IDAssignedToInvoice'] ?? 0 ,
      utlgrremp: json['U_tl_grremp'] ?? 0,
      utlwhsdesc: json['U_tl_whsdesc'] ?? '',
      comments: json['Comments'] ?? '',
      documentStatus: json['DocumentStatus'] ?? '',
      journalMemo: json['JournalMemo'] ?? '',
      address2: json['Address2'] ?? '',
      address: json['Address']  ?? '',
      documentLines: (json['DocumentLines'] as List<dynamic>?)
          ?.map((line) => DocumentLine.fromJson(line))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CardCode': cardCode,
      'CardName': cardName,
      'DocNum': docNum,
      'DocDate': docDate,
      'DocDueDate': docDueDate,
      'TaxDate': taxDate,
      'U_tl_gr': utlgr,
      'ContactPersonCode': contactPersonCode,
      'NumAtCard': numAtCard,
      'BPL_IDAssignedToInvoice': bPLIDAssignedToInvoice,
      'U_tl_grremp': utlgrremp,
      'U_tl_whsdesc': utlwhsdesc,
      'Comments': comments,
      'DocumentStatus': documentStatus,
      'JournalMemo': journalMemo,
      'Address2': address2,
      'Address': address,
      'DocumentLines': documentLines?.map((line) => line.toJson()).toList(),
    };
  }
}

class DocumentLine {
  String? code;
  String? name;
  String? description;

  DocumentLine({
    this.code,
    this.name,
    this.description,
  });

  factory DocumentLine.fromJson(Map<String, dynamic> json) {
    return DocumentLine(
      code: json['Code'],
      name: json['Name'],
      description: json['Description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Code': code,
      'Name': name,
      'Description': description,
    };
  }
}
