class Category_model {
  int statusCode;
  String message;
  List<Categories> data;

  Category_model({this.statusCode, this.message, this.data});

  Category_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Categories>();
      json['data'].forEach((v) {
        data.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int id;
  String name;
  String nameAr;
  String slug;
  int status;
  String photo;
  String isFeatured;
  String image;
  List<Subs> subs;

  Categories(
      {this.id,
      this.name,
      this.nameAr,
      this.slug,
      this.status,
      this.photo,
      this.isFeatured,
      this.image,
      this.subs});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    slug = json['slug'];
    status = int.tryParse(json['status']);
    photo = json['photo'];
    isFeatured = json['is_featured'];
    image = json['image'];
    if (json['subs'] != null) {
      subs = new List<Subs>();
      json['subs'].forEach((v) {
        subs.add(new Subs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['is_featured'] = this.isFeatured;
    data['image'] = this.image;
    if (this.subs != null) {
      data['subs'] = this.subs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subs {
  int id;
  int categoryId;
  String name;
  String nameAr;
  String slug;
  String photo;
  String url;
  int status;

  Subs(
      {this.id,
      this.categoryId,
      this.name,
      this.nameAr,
      this.slug,
      this.photo,
      this.url,
      this.status});

  Subs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = int.tryParse(json['category_id']);
    name = json['name'];
    nameAr = json['name_ar'];
    slug = json['slug'];
    photo = json['photo'];
    url = json['url'];
    status = int.tryParse(json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['slug'] = this.slug;
    data['photo'] = this.photo;
    data['url'] = this.url;
    data['status'] = this.status;
    return data;
  }
}
