import 'dart:convert';

/// categories : [{"id":1,"name":"Pagodas","count":10,"icon":"assets/images/pagoda.png","places":[{"name":"ဆဒ္ဒန်လိုဏ်ဂူတော်","location":"ကရင်ပြည်နယ် ဘားအံမြို့","description":"ဆဒ္ဒန်လိုဏ်ဂူဟုခေါ်ခြင်းအကြောင်း \nလိုဏ်ဂူ၏ပတ်၀န်းကျင်တွင် ဧက ၂၀-ခန့်ကျယ်သော အင်းအိုင်ကြီးရှိသည်။ ထိုအင်းအိုင်ကြီး၏ တောင် ဘက်တွင် ထန့်ဘိုင်းနာ့ခေါ် ဆင်ဟိုင်းတောင်နှင့် အင်းကြီးရှိသည်။ ဆဒ္ဒန်ဆင်မင်းပျော်မွေ့ခဲ့သည့် ဆဒ္ဒန် အိုင်ဟု တင်စားကြသည်။ ထူးဆန်းသော သဘာဝကျောက်တုံး၊ ကျောက်ဆောင်၊ ကျောက်ပန်းခက်တို့ရှိ သည်။ ထိုသဘာ၀တရားတို့သည် ဆဒ္ဒန်ဆင်မင်း ဇာတ်၀တ္ထုနှင့် များစွာတူညီသည်ကို အစွဲပြု၍ ဆဒ္ဒန်ဂူ ဟု ခေါ်တွင်ကြသည်","imageUrl":"assets/images/kaw_goon_cave.png","rating":4.5,"reviewCount":21,"isOpen":true,"distance":46.0,"lat":16.875061,"long":97.632339},{"name":"လင်းနို့ဂူ (Bat Cave)","location":"ကရင်ပြည်နယ် ဘားအံမြို့","description":"လင်းနို့ဂူတဲ့ ဇီဝဗေဒနဲ့သဘာဝကိုချစ်မြတ်နိုးတဲ့သူတွေ အတွက်တော့ တကယ့်အံ့မခန်းစရာနေရာလေးတစ်ခုပါပဲ။ညနေ နေဝင်ချိန်ရောက်တိုင်း ဘီလီယံနဲ့ချီတဲ့ လင်းနို့တွေဟာ ကျောက်တောင်ဂူပေါက်ကနေပျံသန်းထွက်ခွါလာပြီး သံလွင်မြစ်ကြောင်းတစ်လျှောက်မုတ္တမကွေ့အထိ ပင်လယ်ရေသောက်ဆင်းကြပါတယ်။ ဒီလောက်များပြားတဲ့လင်းနို့တွေ ခိုအောင်းပျော်စံရာ ဂူမျိုးကိုအရှေ့တောင်အာရှမှ လာအိုနိုင်ငံမှာတစ်ခု အခုဒီနေရာလေးမှာတစ်ခုသာ တွေ့နိုင်မှာဖြစ်ပါတယ်။ ဘားအံမြို့ခံလူတွေတောင် သိပ်မသိကြပေမယ့် နိုင်ငံတကာကtourists တွေကြားမှာတော့ အလွန်ရေပန်းစားတဲ့နေရာလေး တစ်ခုပဲဖြစ်ပါတယ်။ လင်းနို့တွေကိုစိတ်ဝင်စားတဲ့သူ လင်းနို့တွေကိုလေ့လာတဲ့သူတွေအတွက်သာမက တကယ့်နေဝင်ဆည်းဆာအလှခံစားမှုကိုပါပေးစွမ်းနိုင်တဲ့နေရာလေးဖြစ်ပါတယ်။ ဒီလိုအရှေ့တောင်အာရှမှာနစ်နေရာပဲရှိတဲ့အရာမျိုးကို ကျွန်တော်တို့မြန်မာလူမျိုးတွေ ဒါငါတို့နိုင်ငံကပါလားဆိုပြီး သိသင့်ဂုဏ်ယူသင့်ပါတယ်။ လေ့လာသူတွေ ဇီဝပညာရှင်တွေအနေနဲ့ လဲကွင်းဆက်တွေကိုထိန်းသိမ်းသင့်ပါတယ်။","imageUrl":"assets/images/bat_cave.jfif","rating":4.0,"reviewCount":34,"isOpen":true,"distance":5.4,"lat":16.875061,"long":97.632339}]},{"id":2,"name":"Food & Drinks","count":24,"icon":"assets/images/food-and-drink.png","places":[{"name":"Linn Thiri (2) Coffee & Bake","location":"No. 20, 4 Ward, Kan Nar St, Hpa-An, Myanmar","description":"Cafe, Food and Drinks","imageUrl":"assets/images/lin_thiri.jpg","rating":4.5,"reviewCount":21,"isOpen":true,"distance":46.0,"lat":16.875061,"long":97.632339},{"name":"My Hat Bar & Restaurant","location":" Kan Nar, Road, Hpa-An 13121, Myanmar","description":"Cafe, Food and Drinks","imageUrl":"assets/images/my_hat.jpg","rating":4.0,"reviewCount":34,"isOpen":true,"distance":5.4,"lat":16.875061,"long":97.632339}]},{"id":3,"name":"Hotels","count":123,"icon":"assets/images/building.png","places":[{"name":"Bellagio","location":"ကရင်ပြည်နယ် ဘားအံမြို့","description":"Cafe, Food and Drinks","imageUrl":"assets/images/kaw_goon_cave.png","rating":4.5,"reviewCount":21,"isOpen":true,"distance":46.0,"lat":16.875061,"long":97.632339},{"name":"Coffee house","location":"ကရင်ပြည်နယ် ဘားအံမြို့","description":"Cafe, Food and Drinks","imageUrl":"assets/images/kaw_goon_cave.png","rating":4.0,"reviewCount":34,"isOpen":true,"distance":5.4,"lat":16.875061,"long":97.632339}]},{"id":4,"name":"Shopping","count":24,"icon":"assets/images/shopping-cart.png","places":[{"name":"Bellagio","location":"ကရင်ပြည်နယ် ဘားအံမြို့","description":"Cafe, Food and Drinks","imageUrl":"https://example.com/image1.jpg","rating":4.5,"reviewCount":21,"isOpen":true,"distance":46.0,"lat":16.875061,"long":97.632339},{"name":"Coffee house","location":"ကရင်ပြည်နယ် ဘားအံမြို့","description":"Cafe, Food and Drinks","imageUrl":"https://example.com/image2.jpg","rating":4.0,"reviewCount":34,"isOpen":true,"distance":5.4,"lat":16.875061,"long":97.632339}]}]

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    List<Categories>? categories,
  }) {
    _categories = categories;
  }

  CategoryModel.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
  }
  List<Categories>? _categories;
  CategoryModel copyWith({
    List<Categories>? categories,
  }) =>
      CategoryModel(
        categories: categories ?? _categories,
      );
  List<Categories>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "Pagodas"
/// count : 10
/// icon : "assets/images/pagoda.png"
/// places : [{"name":"ဆဒ္ဒန်လိုဏ်ဂူတော်","location":"ကရင်ပြည်နယ် ဘားအံမြို့","description":"ဆဒ္ဒန်လိုဏ်ဂူဟုခေါ်ခြင်းအကြောင်း \nလိုဏ်ဂူ၏ပတ်၀န်းကျင်တွင် ဧက ၂၀-ခန့်ကျယ်သော အင်းအိုင်ကြီးရှိသည်။ ထိုအင်းအိုင်ကြီး၏ တောင် ဘက်တွင် ထန့်ဘိုင်းနာ့ခေါ် ဆင်ဟိုင်းတောင်နှင့် အင်းကြီးရှိသည်။ ဆဒ္ဒန်ဆင်မင်းပျော်မွေ့ခဲ့သည့် ဆဒ္ဒန် အိုင်ဟု တင်စားကြသည်။ ထူးဆန်းသော သဘာဝကျောက်တုံး၊ ကျောက်ဆောင်၊ ကျောက်ပန်းခက်တို့ရှိ သည်။ ထိုသဘာ၀တရားတို့သည် ဆဒ္ဒန်ဆင်မင်း ဇာတ်၀တ္ထုနှင့် များစွာတူညီသည်ကို အစွဲပြု၍ ဆဒ္ဒန်ဂူ ဟု ခေါ်တွင်ကြသည်","imageUrl":"assets/images/kaw_goon_cave.png","rating":4.5,"reviewCount":21,"isOpen":true,"distance":46.0,"lat":16.875061,"long":97.632339},{"name":"လင်းနို့ဂူ (Bat Cave)","location":"ကရင်ပြည်နယ် ဘားအံမြို့","description":"လင်းနို့ဂူတဲ့ ဇီဝဗေဒနဲ့သဘာဝကိုချစ်မြတ်နိုးတဲ့သူတွေ အတွက်တော့ တကယ့်အံ့မခန်းစရာနေရာလေးတစ်ခုပါပဲ။ညနေ နေဝင်ချိန်ရောက်တိုင်း ဘီလီယံနဲ့ချီတဲ့ လင်းနို့တွေဟာ ကျောက်တောင်ဂူပေါက်ကနေပျံသန်းထွက်ခွါလာပြီး သံလွင်မြစ်ကြောင်းတစ်လျှောက်မုတ္တမကွေ့အထိ ပင်လယ်ရေသောက်ဆင်းကြပါတယ်။ ဒီလောက်များပြားတဲ့လင်းနို့တွေ ခိုအောင်းပျော်စံရာ ဂူမျိုးကိုအရှေ့တောင်အာရှမှ လာအိုနိုင်ငံမှာတစ်ခု အခုဒီနေရာလေးမှာတစ်ခုသာ တွေ့နိုင်မှာဖြစ်ပါတယ်။ ဘားအံမြို့ခံလူတွေတောင် သိပ်မသိကြပေမယ့် နိုင်ငံတကာကtourists တွေကြားမှာတော့ အလွန်ရေပန်းစားတဲ့နေရာလေး တစ်ခုပဲဖြစ်ပါတယ်။ လင်းနို့တွေကိုစိတ်ဝင်စားတဲ့သူ လင်းနို့တွေကိုလေ့လာတဲ့သူတွေအတွက်သာမက တကယ့်နေဝင်ဆည်းဆာအလှခံစားမှုကိုပါပေးစွမ်းနိုင်တဲ့နေရာလေးဖြစ်ပါတယ်။ ဒီလိုအရှေ့တောင်အာရှမှာနစ်နေရာပဲရှိတဲ့အရာမျိုးကို ကျွန်တော်တို့မြန်မာလူမျိုးတွေ ဒါငါတို့နိုင်ငံကပါလားဆိုပြီး သိသင့်ဂုဏ်ယူသင့်ပါတယ်။ လေ့လာသူတွေ ဇီဝပညာရှင်တွေအနေနဲ့ လဲကွင်းဆက်တွေကိုထိန်းသိမ်းသင့်ပါတယ်။","imageUrl":"assets/images/bat_cave.jfif","rating":4.0,"reviewCount":34,"isOpen":true,"distance":5.4,"lat":16.875061,"long":97.632339}]

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));
String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    num? id,
    String? name,
    num? count,
    String? icon,
    List<Places>? places,
  }) {
    _id = id;
    _name = name;
    _count = count;
    _icon = icon;
    _places = places;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _count = json['count'];
    _icon = json['icon'];
    if (json['places'] != null) {
      _places = [];
      json['places'].forEach((v) {
        _places?.add(Places.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  num? _count;
  String? _icon;
  List<Places>? _places;
  Categories copyWith({
    num? id,
    String? name,
    num? count,
    String? icon,
    List<Places>? places,
  }) =>
      Categories(
        id: id ?? _id,
        name: name ?? _name,
        count: count ?? _count,
        icon: icon ?? _icon,
        places: places ?? _places,
      );
  num? get id => _id;
  String? get name => _name;
  num? get count => _count;
  String? get icon => _icon;
  List<Places>? get places => _places;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['count'] = _count;
    map['icon'] = _icon;
    if (_places != null) {
      map['places'] = _places?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "ဆဒ္ဒန်လိုဏ်ဂူတော်"
/// location : "ကရင်ပြည်နယ် ဘားအံမြို့"
/// description : "ဆဒ္ဒန်လိုဏ်ဂူဟုခေါ်ခြင်းအကြောင်း \nလိုဏ်ဂူ၏ပတ်၀န်းကျင်တွင် ဧက ၂၀-ခန့်ကျယ်သော အင်းအိုင်ကြီးရှိသည်။ ထိုအင်းအိုင်ကြီး၏ တောင် ဘက်တွင် ထန့်ဘိုင်းနာ့ခေါ် ဆင်ဟိုင်းတောင်နှင့် အင်းကြီးရှိသည်။ ဆဒ္ဒန်ဆင်မင်းပျော်မွေ့ခဲ့သည့် ဆဒ္ဒန် အိုင်ဟု တင်စားကြသည်။ ထူးဆန်းသော သဘာဝကျောက်တုံး၊ ကျောက်ဆောင်၊ ကျောက်ပန်းခက်တို့ရှိ သည်။ ထိုသဘာ၀တရားတို့သည် ဆဒ္ဒန်ဆင်မင်း ဇာတ်၀တ္ထုနှင့် များစွာတူညီသည်ကို အစွဲပြု၍ ဆဒ္ဒန်ဂူ ဟု ခေါ်တွင်ကြသည်"
/// imageUrl : "assets/images/kaw_goon_cave.png"
/// rating : 4.5
/// reviewCount : 21
/// isOpen : true
/// distance : 46.0
/// lat : 16.875061
/// long : 97.632339

Places placesFromJson(String str) => Places.fromJson(json.decode(str));
String placesToJson(Places data) => json.encode(data.toJson());

class Places {
  Places({
    String? name,
    String? location,
    String? description,
    String? imageUrl,
    num? rating,
    num? reviewCount,
    bool? isOpen,
    num? distance,
    num? lat,
    num? long,
  }) {
    _name = name;
    _location = location;
    _description = description;
    _imageUrl = imageUrl;
    _rating = rating;
    _reviewCount = reviewCount;
    _isOpen = isOpen;
    _distance = distance;
    _lat = lat;
    _long = long;
  }

  Places.fromJson(dynamic json) {
    _name = json['name'];
    _location = json['location'];
    _description = json['description'];
    _imageUrl = json['imageUrl'];
    _rating = json['rating'];
    _reviewCount = json['reviewCount'];
    _isOpen = json['isOpen'];
    _distance = json['distance'];
    _lat = json['lat'];
    _long = json['long'];
  }

  String? _name;
  String? _location;
  String? _description;
  String? _imageUrl;
  num? _rating;
  num? _reviewCount;
  bool? _isOpen;
  num? _distance;
  num? _lat;
  num? _long;

  Places copyWith({
    String? name,
    String? location,
    String? description,
    String? imageUrl,
    num? rating,
    num? reviewCount,
    bool? isOpen,
    num? distance,
    num? lat,
    num? long,
  }) =>
      Places(
        name: name ?? _name,
        location: location ?? _location,
        description: description ?? _description,
        imageUrl: imageUrl ?? _imageUrl,
        rating: rating ?? _rating,
        reviewCount: reviewCount ?? _reviewCount,
        isOpen: isOpen ?? _isOpen,
        distance: distance ?? _distance,
        lat: lat ?? _lat,
        long: long ?? _long,
      );

  String? get name => _name;

  String? get location => _location;

  String? get description => _description;

  String? get imageUrl => _imageUrl;

  num? get rating => _rating;

  num? get reviewCount => _reviewCount;

  bool? get isOpen => _isOpen;

  num? get distance => _distance;

  num? get lat => _lat;

  num? get long => _long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['location'] = _location;
    map['description'] = _description;
    map['imageUrl'] = _imageUrl;
    map['rating'] = _rating;
    map['reviewCount'] = _reviewCount;
    map['isOpen'] = _isOpen;
    map['distance'] = _distance;
    map['lat'] = _lat;
    map['long'] = _long;
    return map;
  }
}
