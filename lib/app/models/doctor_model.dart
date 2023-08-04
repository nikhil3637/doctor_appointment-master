import 'availability_hour_model.dart';
import 'speciality_model.dart';
import 'clinic_model.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'user_model.dart';

class Doctor extends Model {
  String? id;
  String? name;
  String? description;
  List<Media>? images;
  double? price;
  double? discountPrice;
  List<AvailabilityHour>? availabilityHours;
  User? user;
  bool available = false;
  double? rate;
  int? totalReviews;
  bool featured = false;
  bool enableAppointment = false;
  bool enableAtClinic = false;
  bool enableOnlineConsultation = false;
  bool enableAtCustomerAddress = false;
  bool isFavorite = false;
  List<Speciality>? specialities;
  List<Speciality>? subSpecialities;
  Clinic? clinic;

  Doctor(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.price,
      this.discountPrice,
      this.availabilityHours,
      this.available = false,
      this.rate,
      this.user,
      this.totalReviews,
      this.featured = false,
      this.enableAppointment = false,
      this.enableAtClinic = false,
      this.enableOnlineConsultation = false,
      this.enableAtCustomerAddress = false,
      this.isFavorite = false,
      this.specialities,
      this.subSpecialities,
      this.clinic});

  Doctor.fromJson(Map<String, dynamic> json) {
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    price = doubleFromJson(json, 'price');
    discountPrice = doubleFromJson(json, 'discount_price');
    availabilityHours = listFromJson(json, 'availability_hours', (v) => AvailabilityHour.fromJson(v));
    available = boolFromJson(json, 'available');
    rate = doubleFromJson(json, 'rate');
    totalReviews = intFromJson(json, 'total_reviews');
    featured = boolFromJson(json, 'featured');
    enableAppointment = boolFromJson(json, 'enable_appointment');
    enableAtClinic = boolFromJson(json, 'enable_at_clinic');
    enableOnlineConsultation = boolFromJson(json, 'enable_online_consultation');
    enableAtCustomerAddress = boolFromJson(json, 'enable_at_customer_address');
    isFavorite = boolFromJson(json, 'is_favorite');
    specialities = listFromJson<Speciality>(json, 'specialities', (value) => Speciality.fromJson(value));
    subSpecialities = listFromJson<Speciality>(json, 'sub_specialities', (value) => Speciality.fromJson(value));
    clinic = objectFromJson(json, 'clinic', (value) => Clinic.fromJson(value));
    user = objectFromJson(json, 'user', (value) => User.fromJson(value));
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (name != null) data['name'] = this.name;
    if (this.description != null) data['description'] = this.description;
    if (this.price != null) data['price'] = this.price;
    if (discountPrice != null) data['discount_price'] = this.discountPrice;
    data['available'] = this.available;
    if (rate != null) data['rate'] = this.rate;
    if (totalReviews != null) data['total_reviews'] = this.totalReviews;
    data['featured'] = this.featured;
    data['enable_appointment'] = this.enableAppointment;
    data['enable_at_clinic'] = this.enableAtClinic;
    data['enable_at_customer_address'] = this.enableAtCustomerAddress;
    data['enable_online_consultation'] = this.enableOnlineConsultation;
    data['is_favorite'] = this.isFavorite;
    if (this.specialities != null) {
      data['specialities'] = this.specialities!.map((v) => v.id).toList();
    }
    if (this.images != null) {
      data['image'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.subSpecialities != null) {
      data['sub_specialities'] = this.subSpecialities!.map((v) => v.toJson()).toList();
    }
    if (this.clinic != null) {
      if(this.clinic!.hasData)
       data['clinic_id'] = this.clinic!.id;
    }
    if (this.user != null) {
      if(this.user!.hasData)
       data['user_id'] = this.user!.id;
    }
    return data;
  }

  String get firstImageUrl => this.images?.first.url ?? '';

  String get firstImageThumb => this.images?.first.thumb ?? '';

  String get firstImageIcon => this.images?.first.icon ?? '';

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  /*
  * Get the real price of the doctor
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice ?? 0.0 : price ?? 0.0;
  }

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price ?? 0.0 : 0;
  }

  Map<String, List<String>> groupedAvailabilityHours() {
    Map<String, List<String>> result = {};
    this.availabilityHours?.forEach((element) {
      if (result.containsKey(element.day)) {
        result[element.day]?.add((element.startAt ?? '') + ' - ' + (element.endAt ?? ''));
      } else if(element.day != null) {
        result[element.day!] = [(element.startAt ?? '') + ' - ' + (element.endAt ?? '')];
      }
    });
    return result;
  }
  List<String> getAvailabilityHoursData(String day) {
    List<String> result = [];
    this.availabilityHours?.forEach((element) {
      if (element.day == day && element.data != null) {
        result.add(element.data!);
      }
    });
    return result;
  }
  @override
  bool operator ==( other) =>
      identical(this, other) ||
      super == other &&
          other is Doctor &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          rate == other.rate &&
          available == other.available &&
          isFavorite == other.isFavorite &&
          specialities == other.specialities &&
          subSpecialities == other.subSpecialities &&
          user == other.user &&
          clinic == other.clinic;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      rate.hashCode ^
      available.hashCode ^
      clinic.hashCode ^
      user.hashCode ^
      specialities.hashCode ^
      subSpecialities.hashCode ;
}
