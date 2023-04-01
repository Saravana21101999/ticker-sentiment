// To parse this JSON data, do
//
//     final api = apiFromJson(jsonString);

import 'dart:convert';

List<Api> apiFromJson(String str) => List<Api>.from(json.decode(str).map((x) => Api.fromJson(x)));

String apiToJson(List<Api> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Api {
    Api({
        required this.noOfComments,
        required this.sentiment,
        required this.sentimentScore,
        required this.ticker,
    });

    int noOfComments;
    String sentiment;
    double sentimentScore;
    String ticker;

    factory Api.fromJson(Map<String, dynamic> json) => Api(
        noOfComments: json["no_of_comments"],
        sentiment: json["sentiment"],
        sentimentScore: json["sentiment_score"]?.toDouble(),
        ticker: json["ticker"],
    );

    Map<String, dynamic> toJson() => {
        "no_of_comments": noOfComments,
        "sentiment": sentiment,
        "sentiment_score": sentimentScore,
        "ticker": ticker,
    };
}
