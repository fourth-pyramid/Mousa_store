import 'package:mousa_store/features/product/model/product.dart';

class ProductListResponse {
  ProductListResponse({this.success, this.message, this.data});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    Data? parsedData;
    if (json['data'] is Map<String, dynamic>) {
      parsedData = Data.fromJson(json['data'] as Map<String, dynamic>);
    } else if (json['data'] is List) {
      parsedData = Data(
        data: (json['data'] as List<dynamic>)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }

    return ProductListResponse(
      success: json['success'] as bool? ?? json['status'] as bool?,
      message: json['message'] as String?,
      data: parsedData,
    );
  }

  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json['current_page'] as int?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    firstPageUrl: json['first_page_url'] as String?,
    from: json['from'] as int?,
    lastPage: json['last_page'] as int?,
    lastPageUrl: json['last_page_url'] as String?,
    links: (json['links'] as List<dynamic>?)
        ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
        .toList(),
    nextPageUrl: json['next_page_url'] as String?,
    path: json['path'] as String?,
    perPage: json['per_page'] as int?,
    prevPageUrl: json['prev_page_url'],
    to: json['to'] as int?,
    total: json['total'] as int?,
  );

  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'data': data?.map((e) => e.toJson()).toList(),
    'first_page_url': firstPageUrl,
    'from': from,
    'last_page': lastPage,
    'last_page_url': lastPageUrl,
    'links': links?.map((e) => e.toJson()).toList(),
    'next_page_url': nextPageUrl,
    'path': path,
    'per_page': perPage,
    'prev_page_url': prevPageUrl,
    'to': to,
    'total': total,
  };
}

class Link {
  Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json['url'] as String?,
    label: json['label'] as String?,
    active: json['active'] as bool?,
  );

  String? url;
  String? label;
  bool? active;

  Map<String, dynamic> toJson() => {
    'url': url,
    'label': label,
    'active': active,
  };
}
