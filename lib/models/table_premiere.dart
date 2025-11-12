import 'dart:convert';

// Root model untuk response API
class TablePremiereResponse {
  List<TablePremiere> table;

  TablePremiereResponse({
    required this.table,
  });

  factory TablePremiereResponse.fromJson(Map<String, dynamic> json) => TablePremiereResponse(
    table: List<TablePremiere>.from(json["table"].map((x) => TablePremiere.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "table": List<dynamic>.from(table.map((x) => x.toJson())),
  };
}

// Model untuk setiap team
class TablePremiere {
  String idStanding;
  String intRank;
  String idTeam;
  String strTeam;
  String strBadge;
  String idLeague;
  String strLeague;
  String strSeason;
  String strForm;
  String strDescription;
  String intPlayed;
  String intWin;
  String intLoss;
  String intDraw;
  String intGoalsFor;
  String intGoalsAgainst;
  String intGoalDifference;
  String intPoints;
  DateTime dateUpdated;

  TablePremiere({
    required this.idStanding,
    required this.intRank,
    required this.idTeam,
    required this.strTeam,
    required this.strBadge,
    required this.idLeague,
    required this.strLeague,
    required this.strSeason,
    required this.strForm,
    required this.strDescription,
    required this.intPlayed,
    required this.intWin,
    required this.intLoss,
    required this.intDraw,
    required this.intGoalsFor,
    required this.intGoalsAgainst,
    required this.intGoalDifference,
    required this.intPoints,
    required this.dateUpdated,
  });

  factory TablePremiere.fromJson(Map<String, dynamic> json) => TablePremiere(
    idStanding: json["idStanding"] ?? "",
    intRank: json["intRank"] ?? "0",
    idTeam: json["idTeam"] ?? "",
    strTeam: json["strTeam"] ?? "",
    strBadge: json["strBadge"] ?? "",
    idLeague: json["idLeague"] ?? "",
    strLeague: json["strLeague"] ?? "",
    strSeason: json["strSeason"] ?? "",
    strForm: json["strForm"] ?? "",
    strDescription: json["strDescription"] ?? "",
    intPlayed: json["intPlayed"] ?? "0",
    intWin: json["intWin"] ?? "0",
    intLoss: json["intLoss"] ?? "0",
    intDraw: json["intDraw"] ?? "0",
    intGoalsFor: json["intGoalsFor"] ?? "0",
    intGoalsAgainst: json["intGoalsAgainst"] ?? "0",
    intGoalDifference: json["intGoalDifference"] ?? "0",
    intPoints: json["intPoints"] ?? "0",
    dateUpdated: DateTime.parse(json["dateUpdated"]),
  );

  Map<String, dynamic> toJson() => {
    "idStanding": idStanding,
    "intRank": intRank,
    "idTeam": idTeam,
    "strTeam": strTeam,
    "strBadge": strBadge,
    "idLeague": idLeague,
    "strLeague": strLeague,
    "strSeason": strSeason,
    "strForm": strForm,
    "strDescription": strDescription,
    "intPlayed": intPlayed,
    "intWin": intWin,
    "intLoss": intLoss,
    "intDraw": intDraw,
    "intGoalsFor": intGoalsFor,
    "intGoalsAgainst": intGoalsAgainst,
    "intGoalDifference": intGoalDifference,
    "intPoints": intPoints,
    "dateUpdated": dateUpdated.toIso8601String(),
  };
}