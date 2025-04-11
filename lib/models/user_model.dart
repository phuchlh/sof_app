import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final BadgeCounts? badgeCounts;
  final List<Collectives>? collectives;
  final int? accountId;
  final bool? isEmployee;
  final int? lastModifiedDate;
  final int? lastAccessDate;
  final int? reputationChangeYear;
  final int? reputationChangeQuarter;
  final int? reputationChangeMonth;
  final int? reputationChangeWeek;
  final int? reputationChangeDay;
  final int? reputation;
  final int? creationDate;
  final String? userType;
  final int? userId;
  final int? acceptRate;
  final String? location;
  final String? websiteUrl;
  final String? link;
  final String? profileImage;
  final String? displayName;

  const UserModel({
    this.badgeCounts,
    this.collectives,
    this.accountId,
    this.isEmployee,
    this.lastModifiedDate,
    this.lastAccessDate,
    this.reputationChangeYear,
    this.reputationChangeQuarter,
    this.reputationChangeMonth,
    this.reputationChangeWeek,
    this.reputationChangeDay,
    this.reputation,
    this.creationDate,
    this.userType,
    this.userId,
    this.acceptRate,
    this.location,
    this.websiteUrl,
    this.link,
    this.profileImage,
    this.displayName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    badgeCounts:
        json['badge_counts'] != null
            ? BadgeCounts.fromJson(json['badge_counts'])
            : null,
    collectives:
        json['collectives'] != null
            ? (json['collectives'] as List)
                .map((v) => Collectives.fromJson(v))
                .toList()
            : null,
    accountId: json['account_id'],
    isEmployee: json['is_employee'],
    lastModifiedDate: json['last_modified_date'],
    lastAccessDate: json['last_access_date'],
    reputationChangeYear: json['reputation_change_year'],
    reputationChangeQuarter: json['reputation_change_quarter'],
    reputationChangeMonth: json['reputation_change_month'],
    reputationChangeWeek: json['reputation_change_week'],
    reputationChangeDay: json['reputation_change_day'],
    reputation: json['reputation'],
    creationDate: json['creation_date'],
    userType: json['user_type'],
    userId: json['user_id'],
    acceptRate: json['accept_rate'],
    location: json['location'],
    websiteUrl: json['website_url'],
    link: json['link'],
    profileImage: json['profile_image'],
    displayName: json['display_name'],
  );

  Map<String, dynamic> toJson() => {
    'badge_counts': badgeCounts?.toJson(),
    'collectives': collectives?.map((v) => v.toJson()).toList(),
    'account_id': accountId,
    'is_employee': isEmployee,
    'last_modified_date': lastModifiedDate,
    'last_access_date': lastAccessDate,
    'reputation_change_year': reputationChangeYear,
    'reputation_change_quarter': reputationChangeQuarter,
    'reputation_change_month': reputationChangeMonth,
    'reputation_change_week': reputationChangeWeek,
    'reputation_change_day': reputationChangeDay,
    'reputation': reputation,
    'creation_date': creationDate,
    'user_type': userType,
    'user_id': userId,
    'accept_rate': acceptRate,
    'location': location,
    'website_url': websiteUrl,
    'link': link,
    'profile_image': profileImage,
    'display_name': displayName,
  };

  @override
  List<Object?> get props => [
    badgeCounts,
    collectives,
    accountId,
    isEmployee,
    lastModifiedDate,
    lastAccessDate,
    reputationChangeYear,
    reputationChangeQuarter,
    reputationChangeMonth,
    reputationChangeWeek,
    reputationChangeDay,
    reputation,
    creationDate,
    userType,
    userId,
    acceptRate,
    location,
    websiteUrl,
    link,
    profileImage,
    displayName,
  ];
}

class BadgeCounts extends Equatable {
  final int? bronze;
  final int? silver;
  final int? gold;

  const BadgeCounts({this.bronze, this.silver, this.gold});

  factory BadgeCounts.fromJson(Map<String, dynamic> json) => BadgeCounts(
    bronze: json['bronze'],
    silver: json['silver'],
    gold: json['gold'],
  );

  Map<String, dynamic> toJson() => {
    'bronze': bronze,
    'silver': silver,
    'gold': gold,
  };

  @override
  List<Object?> get props => [bronze, silver, gold];
}

class Collectives extends Equatable {
  final Collective? collective;
  final String? role;

  const Collectives({this.collective, this.role});

  factory Collectives.fromJson(Map<String, dynamic> json) => Collectives(
    collective:
        json['collective'] != null
            ? Collective.fromJson(json['collective'])
            : null,
    role: json['role'],
  );

  Map<String, dynamic> toJson() => {
    'collective': collective?.toJson(),
    'role': role,
  };

  @override
  List<Object?> get props => [collective, role];
}

class Collective extends Equatable {
  final List<String>? tags;
  final List<ExternalLinks>? externalLinks;
  final String? description;
  final String? link;
  final String? name;
  final String? slug;

  const Collective({
    this.tags,
    this.externalLinks,
    this.description,
    this.link,
    this.name,
    this.slug,
  });

  factory Collective.fromJson(Map<String, dynamic> json) => Collective(
    tags: (json['tags'] as List?)?.cast<String>(),
    externalLinks:
        json['external_links'] != null
            ? (json['external_links'] as List)
                .map((v) => ExternalLinks.fromJson(v))
                .toList()
            : null,
    description: json['description'],
    link: json['link'],
    name: json['name'],
    slug: json['slug'],
  );

  Map<String, dynamic> toJson() => {
    'tags': tags,
    'external_links': externalLinks?.map((v) => v.toJson()).toList(),
    'description': description,
    'link': link,
    'name': name,
    'slug': slug,
  };

  @override
  List<Object?> get props => [
    tags,
    externalLinks,
    description,
    link,
    name,
    slug,
  ];
}

class ExternalLinks extends Equatable {
  final String? type;
  final String? link;

  const ExternalLinks({this.type, this.link});

  factory ExternalLinks.fromJson(Map<String, dynamic> json) =>
      ExternalLinks(type: json['type'], link: json['link']);

  Map<String, dynamic> toJson() => {'type': type, 'link': link};

  @override
  List<Object?> get props => [type, link];
}
