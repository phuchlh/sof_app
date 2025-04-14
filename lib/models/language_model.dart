
class LanguageModel {
  bool? hasSynonyms;
  int? userId;
  bool? isModeratorOnly;
  bool? isRequired;
  int? count;
  String? name;
  List<Collectives>? collectives;

  LanguageModel(
      {this.hasSynonyms,
      this.userId,
      this.isModeratorOnly,
      this.isRequired,
      this.count,
      this.name,
      this.collectives});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    hasSynonyms = json['has_synonyms'];
    userId = json['user_id'];
    isModeratorOnly = json['is_moderator_only'];
    isRequired = json['is_required'];
    count = json['count'];
    name = json['name'];
    if (json['collectives'] != null) {
      collectives = <Collectives>[];
      json['collectives'].forEach((v) {
        collectives!.add(new Collectives.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_synonyms'] = this.hasSynonyms;
    data['user_id'] = this.userId;
    data['is_moderator_only'] = this.isModeratorOnly;
    data['is_required'] = this.isRequired;
    data['count'] = this.count;
    data['name'] = this.name;
    if (this.collectives != null) {
      data['collectives'] = this.collectives!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collectives {
  List<String>? tags;
  List<ExternalLinks>? externalLinks;
  String? description;
  String? link;
  String? name;
  String? slug;

  Collectives(
      {this.tags,
      this.externalLinks,
      this.description,
      this.link,
      this.name,
      this.slug});

  Collectives.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].cast<String>();
    if (json['external_links'] != null) {
      externalLinks = <ExternalLinks>[];
      json['external_links'].forEach((v) {
        externalLinks!.add(new ExternalLinks.fromJson(v));
      });
    }
    description = json['description'];
    link = json['link'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tags'] = this.tags;
    if (this.externalLinks != null) {
      data['external_links'] =
          this.externalLinks!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['link'] = this.link;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class ExternalLinks {
  String? type;
  String? link;

  ExternalLinks({this.type, this.link});

  ExternalLinks.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['link'] = this.link;
    return data;
  }
}