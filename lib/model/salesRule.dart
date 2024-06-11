class SalesRule {
  final double pbID;
  final String pbRulesNo;
  final String pbRulesTypeName;

  SalesRule({
    required this.pbID,
    required this.pbRulesNo,
    required this.pbRulesTypeName,
  });

  factory SalesRule.fromJson(Map<String, dynamic> json) {
    return SalesRule(
      pbID: json['pb_ID'],
      pbRulesNo: json['pb_RulesNo'],
      pbRulesTypeName: json['pb_RulesTypeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pb_ID': pbID,
      'pb_RulesNo': pbRulesNo,
      'pb_RulesTypeName': pbRulesTypeName,
    };
  }
}
