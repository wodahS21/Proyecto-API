// To parse this JSON data, do
//
//     final cardsRespose = cardsResposeFromJson(jsonString);

import 'dart:convert';

CardsRespose cardsResposeFromJson(String str) =>
    CardsRespose.fromJson(json.decode(str));

String cardsResposeToJson(CardsRespose data) => json.encode(data.toJson());

class CardsRespose {
  List<pokecard>? data;
  int? page;
  int? pageSize;
  int? count;
  int? totalCount;

  CardsRespose({
    this.data,
    this.page,
    this.pageSize,
    this.count,
    this.totalCount,
  });

  factory CardsRespose.fromJson(Map<String, dynamic> json) => CardsRespose(
        data: json["data"] == null
            ? []
            : List<pokecard>.from(
                json["data"]!.map((x) => pokecard.fromJson(x))),
        page: json["page"],
        pageSize: json["pageSize"],
        count: json["count"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "page": page,
        "pageSize": pageSize,
        "count": count,
        "totalCount": totalCount,
      };
}

class pokecard {
  String? id;
  String? name;
  String? supertype;
  List<String>? subtypes;
  String? hp;
  List<String>? types;
  String? evolvesFrom;
  List<Attack>? attacks;
  List<Resistance>? weaknesses;
  List<Resistance>? resistances;
  List<String>? retreatCost;
  int? convertedRetreatCost;
  Set? pokecardSet;
  String? number;
  String? artist;
  String? rarity;
  String? flavorText;
  List<int>? nationalPokedexNumbers;
  Legalities? legalities;
  pokecardImages? images;
  Tcgplayer? tcgplayer;
  Cardmarket? cardmarket;
  List<String>? evolvesTo;
  String? level;
  List<Ability>? abilities;
  List<String>? rules;
  String? regulationMark;

  pokecard({
    this.id,
    this.name,
    this.supertype,
    this.subtypes,
    this.hp,
    this.types,
    this.evolvesFrom,
    this.attacks,
    this.weaknesses,
    this.resistances,
    this.retreatCost,
    this.convertedRetreatCost,
    this.pokecardSet,
    this.number,
    this.artist,
    this.rarity,
    this.flavorText,
    this.nationalPokedexNumbers,
    this.legalities,
    this.images,
    this.tcgplayer,
    this.cardmarket,
    this.evolvesTo,
    this.level,
    this.abilities,
    this.rules,
    this.regulationMark,
  });

  factory pokecard.fromJson(Map<String, dynamic> json) => pokecard(
        id: json["id"],
        name: json["name"],
        supertype: json["supertype"],
        subtypes: json["subtypes"] == null
            ? []
            : List<String>.from(json["subtypes"]!.map((x) => x)),
        hp: json["hp"],
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
        evolvesFrom: json["evolvesFrom"],
        attacks: json["attacks"] == null
            ? []
            : List<Attack>.from(
                json["attacks"]!.map((x) => Attack.fromJson(x))),
        weaknesses: json["weaknesses"] == null
            ? []
            : List<Resistance>.from(
                json["weaknesses"]!.map((x) => Resistance.fromJson(x))),
        resistances: json["resistances"] == null
            ? []
            : List<Resistance>.from(
                json["resistances"]!.map((x) => Resistance.fromJson(x))),
        retreatCost: json["retreatCost"] == null
            ? []
            : List<String>.from(json["retreatCost"]!.map((x) => x)),
        convertedRetreatCost: json["convertedRetreatCost"],
        pokecardSet: json["set"] == null ? null : Set.fromJson(json["set"]),
        number: json["number"],
        artist: json["artist"],
        rarity: json["rarity"],
        flavorText: json["flavorText"],
        nationalPokedexNumbers: json["nationalPokedexNumbers"] == null
            ? []
            : List<int>.from(json["nationalPokedexNumbers"]!.map((x) => x)),
        legalities: json["legalities"] == null
            ? null
            : Legalities.fromJson(json["legalities"]),
        images: json["images"] == null
            ? null
            : pokecardImages.fromJson(json["images"]),
        tcgplayer: json["tcgplayer"] == null
            ? null
            : Tcgplayer.fromJson(json["tcgplayer"]),
        cardmarket: json["cardmarket"] == null
            ? null
            : Cardmarket.fromJson(json["cardmarket"]),
        evolvesTo: json["evolvesTo"] == null
            ? []
            : List<String>.from(json["evolvesTo"]!.map((x) => x)),
        level: json["level"],
        abilities: json["abilities"] == null
            ? []
            : List<Ability>.from(
                json["abilities"]!.map((x) => Ability.fromJson(x))),
        rules: json["rules"] == null
            ? []
            : List<String>.from(json["rules"]!.map((x) => x)),
        regulationMark: json["regulationMark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "supertype": supertype,
        "subtypes":
            subtypes == null ? [] : List<dynamic>.from(subtypes!.map((x) => x)),
        "hp": hp,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
        "evolvesFrom": evolvesFrom,
        "attacks": attacks == null
            ? []
            : List<dynamic>.from(attacks!.map((x) => x.toJson())),
        "weaknesses": weaknesses == null
            ? []
            : List<dynamic>.from(weaknesses!.map((x) => x.toJson())),
        "resistances": resistances == null
            ? []
            : List<dynamic>.from(resistances!.map((x) => x.toJson())),
        "retreatCost": retreatCost == null
            ? []
            : List<dynamic>.from(retreatCost!.map((x) => x)),
        "convertedRetreatCost": convertedRetreatCost,
        "set": pokecardSet?.toJson(),
        "number": number,
        "artist": artist,
        "rarity": rarity,
        "flavorText": flavorText,
        "nationalPokedexNumbers": nationalPokedexNumbers == null
            ? []
            : List<dynamic>.from(nationalPokedexNumbers!.map((x) => x)),
        "legalities": legalities?.toJson(),
        "images": images?.toJson(),
        "tcgplayer": tcgplayer?.toJson(),
        "cardmarket": cardmarket?.toJson(),
        "evolvesTo": evolvesTo == null
            ? []
            : List<dynamic>.from(evolvesTo!.map((x) => x)),
        "level": level,
        "abilities": abilities == null
            ? []
            : List<dynamic>.from(abilities!.map((x) => x.toJson())),
        "rules": rules == null ? [] : List<dynamic>.from(rules!.map((x) => x)),
        "regulationMark": regulationMark,
      };
}

class Ability {
  String? name;
  String? text;
  String? type;

  Ability({
    this.name,
    this.text,
    this.type,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        name: json["name"],
        text: json["text"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "text": text,
        "type": type,
      };
}

class Attack {
  String? name;
  List<String>? cost;
  int? convertedEnergyCost;
  String? damage;
  String? text;

  Attack({
    this.name,
    this.cost,
    this.convertedEnergyCost,
    this.damage,
    this.text,
  });

  factory Attack.fromJson(Map<String, dynamic> json) => Attack(
        name: json["name"],
        cost: json["cost"] == null
            ? []
            : List<String>.from(json["cost"]!.map((x) => x)),
        convertedEnergyCost: json["convertedEnergyCost"],
        damage: json["damage"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cost": cost == null ? [] : List<dynamic>.from(cost!.map((x) => x)),
        "convertedEnergyCost": convertedEnergyCost,
        "damage": damage,
        "text": text,
      };
}

class Cardmarket {
  String? url;
  String? updatedAt;
  Map<String, double>? prices;

  Cardmarket({
    this.url,
    this.updatedAt,
    this.prices,
  });

  factory Cardmarket.fromJson(Map<String, dynamic> json) => Cardmarket(
        url: json["url"],
        updatedAt: json["updatedAt"],
        prices: Map.from(json["prices"]!)
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "updatedAt": updatedAt,
        "prices":
            Map.from(prices!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Set {
  String? id;
  String? name;
  String? series;
  int? printedTotal;
  int? total;
  Legalities? legalities;
  String? ptcgoCode;
  String? releaseDate;
  String? updatedAt;
  SetImages? images;

  Set({
    this.id,
    this.name,
    this.series,
    this.printedTotal,
    this.total,
    this.legalities,
    this.ptcgoCode,
    this.releaseDate,
    this.updatedAt,
    this.images,
  });

  factory Set.fromJson(Map<String, dynamic> json) => Set(
        id: json["id"],
        name: json["name"],
        series: json["series"],
        printedTotal: json["printedTotal"],
        total: json["total"],
        legalities: json["legalities"] == null
            ? null
            : Legalities.fromJson(json["legalities"]),
        ptcgoCode: json["ptcgoCode"],
        releaseDate: json["releaseDate"],
        updatedAt: json["updatedAt"],
        images:
            json["images"] == null ? null : SetImages.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "series": series,
        "printedTotal": printedTotal,
        "total": total,
        "legalities": legalities?.toJson(),
        "ptcgoCode": ptcgoCode,
        "releaseDate": releaseDate,
        "updatedAt": updatedAt,
        "images": images?.toJson(),
      };
}

class SetImages {
  String? symbol;
  String? logo;

  SetImages({
    this.symbol,
    this.logo,
  });

  factory SetImages.fromJson(Map<String, dynamic> json) => SetImages(
        symbol: json["symbol"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "logo": logo,
      };
}

class Legalities {
  String? unlimited;
  String? expanded;

  Legalities({
    this.unlimited,
    this.expanded,
  });

  factory Legalities.fromJson(Map<String, dynamic> json) => Legalities(
        unlimited: json["unlimited"],
        expanded: json["expanded"],
      );

  Map<String, dynamic> toJson() => {
        "unlimited": unlimited,
        "expanded": expanded,
      };
}

class pokecardImages {
  String? small;
  String? large;

  pokecardImages({
    this.small,
    this.large,
  });

  factory pokecardImages.fromJson(Map<String, dynamic> json) => pokecardImages(
        small: json["small"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "large": large,
      };
}

class Resistance {
  String? type;
  String? value;

  Resistance({
    this.type,
    this.value,
  });

  factory Resistance.fromJson(Map<String, dynamic> json) => Resistance(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class Tcgplayer {
  String? url;
  String? updatedAt;
  Prices? prices;

  Tcgplayer({
    this.url,
    this.updatedAt,
    this.prices,
  });

  factory Tcgplayer.fromJson(Map<String, dynamic> json) => Tcgplayer(
        url: json["url"],
        updatedAt: json["updatedAt"],
        prices: json["prices"] == null ? null : Prices.fromJson(json["prices"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "updatedAt": updatedAt,
        "prices": prices?.toJson(),
      };
}

class Prices {
  The1StEditionHolofoil? holofoil;
  The1StEditionHolofoil? reverseHolofoil;
  The1StEditionHolofoil? normal;
  The1StEditionHolofoil? the1StEditionHolofoil;
  The1StEditionHolofoil? unlimitedHolofoil;

  Prices({
    this.holofoil,
    this.reverseHolofoil,
    this.normal,
    this.the1StEditionHolofoil,
    this.unlimitedHolofoil,
  });

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        holofoil: json["holofoil"] == null
            ? null
            : The1StEditionHolofoil.fromJson(json["holofoil"]),
        reverseHolofoil: json["reverseHolofoil"] == null
            ? null
            : The1StEditionHolofoil.fromJson(json["reverseHolofoil"]),
        normal: json["normal"] == null
            ? null
            : The1StEditionHolofoil.fromJson(json["normal"]),
        the1StEditionHolofoil: json["1stEditionHolofoil"] == null
            ? null
            : The1StEditionHolofoil.fromJson(json["1stEditionHolofoil"]),
        unlimitedHolofoil: json["unlimitedHolofoil"] == null
            ? null
            : The1StEditionHolofoil.fromJson(json["unlimitedHolofoil"]),
      );

  Map<String, dynamic> toJson() => {
        "holofoil": holofoil?.toJson(),
        "reverseHolofoil": reverseHolofoil?.toJson(),
        "normal": normal?.toJson(),
        "1stEditionHolofoil": the1StEditionHolofoil?.toJson(),
        "unlimitedHolofoil": unlimitedHolofoil?.toJson(),
      };
}

class The1StEditionHolofoil {
  double? low;
  double? mid;
  double? high;
  double? market;
  double? directLow;

  The1StEditionHolofoil({
    this.low,
    this.mid,
    this.high,
    this.market,
    this.directLow,
  });

  factory The1StEditionHolofoil.fromJson(Map<String, dynamic> json) =>
      The1StEditionHolofoil(
        low: json["low"]?.toDouble(),
        mid: json["mid"]?.toDouble(),
        high: json["high"]?.toDouble(),
        market: json["market"]?.toDouble(),
        directLow: json["directLow"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "mid": mid,
        "high": high,
        "market": market,
        "directLow": directLow,
      };
}
