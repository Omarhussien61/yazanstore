class Ads {
  List<Sliders> Rsliders;
  List<Sliders> Lsliders;

  Ads({this.Rsliders});
  Ads.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      Rsliders = new List<Sliders>();
      Lsliders = new List<Sliders>();
      json['data'].forEach((v) {
        if (v['view_in'] == 'slide-right') {
          Rsliders.add(new Sliders.fromJson(v));
        } else {
          Lsliders.add(new Sliders.fromJson(v));
        }
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.Rsliders != null) {
      data['data'] = this.Rsliders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  String id;
  String subtitleText;
  String subtitleSize;
  String subtitleColor;
  String subtitleAnime;
  String titleText;
  String titleSize;
  String titleColor;
  String titleAnime;
  String detailsText;
  String detailsSize;
  String detailsColor;
  String detailsAnime;
  String photo;
  String position;
  String link;
  String viewIn;

  Sliders(
      {this.id,
      this.subtitleText,
      this.subtitleSize,
      this.subtitleColor,
      this.subtitleAnime,
      this.titleText,
      this.titleSize,
      this.titleColor,
      this.titleAnime,
      this.detailsText,
      this.detailsSize,
      this.detailsColor,
      this.detailsAnime,
      this.photo,
      this.position,
      this.link,
      this.viewIn});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    subtitleText = json['subtitle_text'];
    subtitleSize = json['subtitle_size'];
    subtitleColor = json['subtitle_color'];
    subtitleAnime = json['subtitle_anime'];
    titleText = json['title_text'];
    titleSize = json['title_size'];
    titleColor = json['title_color'];
    titleAnime = json['title_anime'];
    detailsText = json['details_text'];
    detailsSize = json['details_size'];
    detailsColor = json['details_color'];
    detailsAnime = json['details_anime'];
    photo = json['photo'];
    position = json['position'];
    link = json['link'];
    viewIn = json['view_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subtitle_text'] = this.subtitleText;
    data['subtitle_size'] = this.subtitleSize;
    data['subtitle_color'] = this.subtitleColor;
    data['subtitle_anime'] = this.subtitleAnime;
    data['title_text'] = this.titleText;
    data['title_size'] = this.titleSize;
    data['title_color'] = this.titleColor;
    data['title_anime'] = this.titleAnime;
    data['details_text'] = this.detailsText;
    data['details_size'] = this.detailsSize;
    data['details_color'] = this.detailsColor;
    data['details_anime'] = this.detailsAnime;
    data['photo'] = this.photo;
    data['position'] = this.position;
    data['link'] = this.link;
    data['view_in'] = this.viewIn;
    return data;
  }
}
