class GBookResult {
  List<Item> items;
  String kind;
  int totalItems;

  GBookResult({this.items, this.kind, this.totalItems});

  factory GBookResult.fromJson(Map<String, dynamic> json) {
    return GBookResult(
      items: json['items'] != null
          ? (json['items'] as List).map((i) => Item.fromJson(i)).toList()
          : null,
      kind: json['kind'],
      totalItems: json['totalItems'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['totalItems'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  AccessInfo accessInfo;
  String eTag;
  String id;
  String kind;
  SaleInfo saleInfo;
  SearchInfo searchInfo;
  String selfLink;
  VolumeInfo volumeInfo;

  Item(
      {this.accessInfo,
      this.eTag,
      this.id,
      this.kind,
      this.saleInfo,
      this.searchInfo,
      this.selfLink,
      this.volumeInfo});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      accessInfo: json['accessInfo'] != null
          ? AccessInfo.fromJson(json['accessInfo'])
          : null,
      eTag: json['etag'],
      id: json['id'],
      kind: json['kind'],
      saleInfo:
          json['saleInfo'] != null ? SaleInfo.fromJson(json['saleInfo']) : null,
      searchInfo: json['searchInfo'] != null
          ? SearchInfo.fromJson(json['searchInfo'])
          : null,
      selfLink: json['selfLink'],
      volumeInfo: json['volumeInfo'] != null
          ? VolumeInfo.fromJson(json['volumeInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['etag'] = this.eTag;
    data['id'] = this.id;
    data['kind'] = this.kind;
    data['selfLink'] = this.selfLink;
    if (this.accessInfo != null) {
      data['accessInfo'] = this.accessInfo.toJson();
    }
    if (this.saleInfo != null) {
      data['saleInfo'] = this.saleInfo.toJson();
    }
    if (this.searchInfo != null) {
      data['searchInfo'] = this.searchInfo.toJson();
    }
    if (this.volumeInfo != null) {
      data['volumeInfo'] = this.volumeInfo.toJson();
    }
    return data;
  }
}

class VolumeInfo {
  bool allowAnonLogging;
  List<String> authors;
  double averageRating;
  String canonicalVolumeLink;
  List<String> categories;
  String contentVersion;
  String description;
  ImageLinks imageLinks;
  List<IndustryIdentifier> industryIdentifiers;
  String infoLink;
  String language;
  String maturityRating;
  int pageCount;
  String previewLink;
  String printType;
  String publishedDate;
  String publisher;
  int ratingsCount;
  ReadingModes readingModes;
  String subtitle;
  String title;

  VolumeInfo(
      {this.allowAnonLogging,
      this.authors,
      this.averageRating,
      this.canonicalVolumeLink,
      this.categories,
      this.contentVersion,
      this.description,
      this.imageLinks,
      this.industryIdentifiers,
      this.infoLink,
      this.language,
      this.maturityRating,
      this.pageCount,
      this.previewLink,
      this.printType,
      this.publishedDate,
      this.publisher,
      this.ratingsCount,
      this.readingModes,
      this.subtitle,
      this.title});

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      allowAnonLogging: json['allowAnonLogging'],
      authors: json['authors'] != null
          ? new List<String>.from(json['authors'])
          : null,
      averageRating: json['averageRating'],
      canonicalVolumeLink: json['canonicalVolumeLink'],
      categories: json['categories'] != null
          ? new List<String>.from(json['categories'])
          : null,
      contentVersion: json['contentVersion'],
      description: json['description'],
      imageLinks: json['imageLinks'] != null
          ? ImageLinks.fromJson(json['imageLinks'])
          : null,
      industryIdentifiers: json['industryIdentifiers'] != null
          ? (json['industryIdentifiers'] as List)
              .map((i) => IndustryIdentifier.fromJson(i))
              .toList()
          : null,
      infoLink: json['infoLink'],
      language: json['language'],
      maturityRating: json['maturityRating'],
      pageCount: json['pageCount'],
      previewLink: json['previewLink'],
      printType: json['printType'],
      publishedDate: json['publishedDate'],
      publisher: json['publisher'],
      ratingsCount: json['ratingsCount'],
      readingModes: json['readingModes'] != null
          ? ReadingModes.fromJson(json['readingModes'])
          : null,
      subtitle: json['subtitle'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowAnonLogging'] = this.allowAnonLogging;
    data['averageRating'] = this.averageRating;
    data['canonicalVolumeLink'] = this.canonicalVolumeLink;
    data['contentVersion'] = this.contentVersion;
    data['description'] = this.description;
    data['infoLink'] = this.infoLink;
    data['language'] = this.language;
    data['maturityRating'] = this.maturityRating;
    data['pageCount'] = this.pageCount;
    data['previewLink'] = this.previewLink;
    data['printType'] = this.printType;
    data['publishedDate'] = this.publishedDate;
    data['publisher'] = this.publisher;
    data['ratingsCount'] = this.ratingsCount;
    data['subtitle'] = this.subtitle;
    data['title'] = this.title;
    if (this.authors != null) {
      data['authors'] = this.authors;
    }
    if (this.categories != null) {
      data['categories'] = this.categories;
    }
    if (this.imageLinks != null) {
      data['imageLinks'] = this.imageLinks.toJson();
    }
    if (this.industryIdentifiers != null) {
      data['industryIdentifiers'] =
          this.industryIdentifiers.map((v) => v.toJson()).toList();
    }
    if (this.readingModes != null) {
      data['readingModes'] = this.readingModes.toJson();
    }
    return data;
  }
}

class IndustryIdentifier {
  String identifier;
  String type;

  IndustryIdentifier({this.identifier, this.type});

  factory IndustryIdentifier.fromJson(Map<String, dynamic> json) {
    return IndustryIdentifier(
      identifier: json['identifier'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['type'] = this.type;
    return data;
  }
}

class ReadingModes {
  bool image;
  bool text;

  ReadingModes({this.image, this.text});

  factory ReadingModes.fromJson(Map<String, dynamic> json) {
    return ReadingModes(
      image: json['image'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['text'] = this.text;
    return data;
  }
}

class ImageLinks {
  String smallThumbnail;
  String thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      smallThumbnail: json['smallThumbnail'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['smallThumbnail'] = this.smallThumbnail;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class SaleInfo {
  String country;
  bool isEbook;
  String saleability;

  SaleInfo({this.country, this.isEbook, this.saleability});

  factory SaleInfo.fromJson(Map<String, dynamic> json) {
    return SaleInfo(
      country: json['country'],
      isEbook: json['isEbook'],
      saleability: json['saleability'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['isEbook'] = this.isEbook;
    data['saleability'] = this.saleability;
    return data;
  }
}

class AccessInfo {
  String accessViewStatus;
  String country;
  bool embeddable;
  Epub epub;
  Pdf pdf;
  bool publicDomain;
  bool quoteSharingAllowed;
  String textToSpeechPermission;
  String viewability;
  String webReaderLink;

  AccessInfo(
      {this.accessViewStatus,
      this.country,
      this.embeddable,
      this.epub,
      this.pdf,
      this.publicDomain,
      this.quoteSharingAllowed,
      this.textToSpeechPermission,
      this.viewability,
      this.webReaderLink});

  factory AccessInfo.fromJson(Map<String, dynamic> json) {
    return AccessInfo(
      accessViewStatus: json['accessViewStatus'],
      country: json['country'],
      embeddable: json['embeddable'],
      epub: json['epub'] != null ? Epub.fromJson(json['epub']) : null,
      pdf: json['pdf'] != null ? Pdf.fromJson(json['pdf']) : null,
      publicDomain: json['publicDomain'],
      quoteSharingAllowed: json['quoteSharingAllowed'],
      textToSpeechPermission: json['textToSpeechPermission'],
      viewability: json['viewability'],
      webReaderLink: json['webReaderLink'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessViewStatus'] = this.accessViewStatus;
    data['country'] = this.country;
    data['embeddable'] = this.embeddable;
    data['publicDomain'] = this.publicDomain;
    data['quoteSharingAllowed'] = this.quoteSharingAllowed;
    data['textToSpeechPermission'] = this.textToSpeechPermission;
    data['viewability'] = this.viewability;
    data['webReaderLink'] = this.webReaderLink;
    if (this.epub != null) {
      data['epub'] = this.epub.toJson();
    }
    if (this.pdf != null) {
      data['pdf'] = this.pdf.toJson();
    }
    return data;
  }
}

class Pdf {
  bool isAvailable;

  Pdf({this.isAvailable});

  factory Pdf.fromJson(Map<String, dynamic> json) {
    return Pdf(
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}

class Epub {
  bool isAvailable;

  Epub({this.isAvailable});

  factory Epub.fromJson(Map<String, dynamic> json) {
    return Epub(
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}

class SearchInfo {
  String textSnippet;

  SearchInfo({this.textSnippet});

  factory SearchInfo.fromJson(Map<String, dynamic> json) {
    return SearchInfo(
      textSnippet: json['textSnippet'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['textSnippet'] = this.textSnippet;
    return data;
  }
}
