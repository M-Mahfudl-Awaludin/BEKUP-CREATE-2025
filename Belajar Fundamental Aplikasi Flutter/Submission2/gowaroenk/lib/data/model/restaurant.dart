class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'] ?? '');
  }
}

class MenuItem {
  final String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(name: json['name'] ?? '');
  }
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name']?.toString() ?? '-',   // pastikan String
      review: json['review']?.toString() ?? '-',
      date: json['date']?.toString() ?? '',   // tanggal bisa kosong
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'review': review,
      'date': date,
    };
  }
}


class Menus {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json['foods'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e))
          .toList(),
    );
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String? address;
  final double rating;
  final List<Category>? categories;
  final Menus? menus;
  final List<CustomerReview>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    this.address,
    required this.rating,
    this.categories,
    this.menus,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pictureId: json['pictureId'] ?? '',
      city: json['city'] ?? '',
      address: json['address'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      categories: json['categories'] != null
          ? (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList()
          : null,
      menus: json['menus'] != null ? Menus.fromJson(json['menus']) : null,
      customerReviews: json['customerReviews'] != null
          ? (json['customerReviews'] as List<dynamic>)
          .map((e) => CustomerReview.fromJson(e))
          .toList()
          : null,
    );
  }

  String get imageSmall =>
      "https://restaurant-api.dicoding.dev/images/small/$pictureId";

  String get imageMedium =>
      "https://restaurant-api.dicoding.dev/images/medium/$pictureId";

  String get imageLarge =>
      "https://restaurant-api.dicoding.dev/images/large/$pictureId";

  String get image => imageMedium;

  String get safeAddress => address ?? '-';
}

