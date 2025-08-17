class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name']);
  }
}

class MenuItem {
  final String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(name: json['name']);
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
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }
}

class Menus {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json['foods'] as List).map((e) => MenuItem.fromJson(e)).toList(),
      drinks: (json['drinks'] as List).map((e) => MenuItem.fromJson(e)).toList(),
    );
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String? address; // hanya ada di detail
  final double rating;
  final List<Category>? categories; // hanya ada di detail
  final Menus? menus; // hanya ada di detail
  final List<CustomerReview>? customerReviews; // hanya ada di detail

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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      address: json['address'],
      rating: (json['rating'] as num).toDouble(),
      categories: json['categories'] != null
          ? (json['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList()
          : null,
      menus: json['menus'] != null ? Menus.fromJson(json['menus']) : null,
      customerReviews: json['customerReviews'] != null
          ? (json['customerReviews'] as List)
          .map((e) => CustomerReview.fromJson(e))
          .toList()
          : null,
    );
  }
}
