class TransactionResponse {
  TransactionResponse({
    required this.transactionHash,
    required this.transactionIndex,
    required this.blockNumber,
    required this.blockHash,
    required this.from,
    required this.to,
    required this.cumulativeGasUsed,
    required this.gasUsed,
    required this.logs,
    required this.logsBloom,
    required this.status,
    required this.effectiveGasPrice,
    required this.type,
    required this.amount
  });

  final int? amount;
  final String? transactionHash;
  final int? transactionIndex;
  final int? blockNumber;
  final String? blockHash;
  final String? from;
  final String? to;
  final int? cumulativeGasUsed;
  final dynamic gasUsed;
  final List<dynamic> logs;
  final String? logsBloom;
  final int? status;
  final int? effectiveGasPrice;
  final int? type;

  factory TransactionResponse.fromJson(Map<String, dynamic> json){
    return TransactionResponse(
      amount: json['amount'],
      transactionHash: json["transactionHash"],
      transactionIndex: json["transactionIndex"],
      blockNumber: json["blockNumber"],
      blockHash: json["blockHash"],
      from: json["from"],
      to: json["to"],
      cumulativeGasUsed: json["cumulativeGasUsed"],
      gasUsed: json["gasUsed"],
      logs: json["logs"] == null ? [] : List<dynamic>.from(json["logs"]!.map((x) => x)),
      logsBloom: json["logsBloom"],
      status: json["status"],
      effectiveGasPrice: json["effectiveGasPrice"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
    'amount':amount,
    "transactionHash": transactionHash,
    "transactionIndex": transactionIndex,
    "blockNumber": blockNumber,
    "blockHash": blockHash,
    "from": from,
    "to": to,
    "cumulativeGasUsed": cumulativeGasUsed,
    "gasUsed": gasUsed,
    "logs": logs.map((x) => x).toList(),
    "logsBloom": logsBloom,
    "status": status,
    "effectiveGasPrice": effectiveGasPrice,
    "type": type,
  };

}
