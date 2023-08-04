/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'package:doctors_appointments/app/models/user_model.dart';

import 'address_model.dart';
import 'clinic_level_model.dart';
import 'doctor_model.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'review_model.dart';
import 'tax_model.dart';

class Clinic extends Model {
  String? id;
  String? name;
  String? description;
  List<Media>? images;
  String? phoneNumber;
  String? mobileNumber;
  ClinicLevel? level;
  double? availabilityRange;
  double? distance;
  bool available = false;
  bool featured = false;
  Address? address;
  List<Tax>? taxes;
  double? rate;
  List<Review>? reviews;
  List<User>? employees;
  int? totalReviews;
  bool verified = false;
  int? total_appointments;
  List<Doctor>? doctors;

  Clinic(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.phoneNumber,
      this.mobileNumber,
      this.level,
      this.availabilityRange,
      this.distance,
      this.available = false,
      this.featured = false,
      this.employees,
      this.address,
      this.rate,
      this.reviews,
      this.totalReviews,
      this.verified = false,
      this.total_appointments,
      this.doctors,
      });

  Clinic.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    phoneNumber = stringFromJson(json, 'phone_number');
    mobileNumber = stringFromJson(json, 'mobile_number');
    level = objectFromJson(json, 'clinic_level', (v) => ClinicLevel.fromJson(v));
    availabilityRange = doubleFromJson(json, 'availability_range');
    distance = doubleFromJson(json, 'distance');
    available = boolFromJson(json, 'available');
    featured = boolFromJson(json, 'featured');
    address = objectFromJson(json, 'address', (v) => Address.fromJson(v));    
    taxes = listFromJson(json, 'taxes', (v) => Tax.fromJson(v));
    employees = listFromJson(json, 'users', (v) => User.fromJson(v));
    rate = doubleFromJson(json, 'rate');
    reviews = listFromJson(json, 'clinic_reviews', (v) => Review.fromJson(v));
    totalReviews = reviews?.isEmpty ?? false ? intFromJson(json, 'total_reviews') : reviews?.length;
    verified = boolFromJson(json, 'verified');
    total_appointments = intFromJson(json, 'total_appointments');
    if(json['doctoremr'] != null) {
      doctors = [];
      doctors = listFromJson(json, 'doctoremr', (v) => Doctor.fromJson(v));
    }

    if(json['doctors'] != null) {
      doctors = [];
      doctors = listFromJson(json, 'doctors', (v) => Doctor.fromJson(v));
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['available'] = this.available;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['rate'] = this.rate;
    data['total_reviews'] = this.totalReviews;
    data['verified'] = this.verified;
    data['total_appointments'] = this.total_appointments;
    data['distance'] = this.distance;
    if (this.employees != null) {
      data['users'] = this.employees?.map((v) => v.toJson()).toList();
    }
    if(this.doctors != null) {
      data['doctors'] = this.doctors?.map((v) => v.toJson()).toList();
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


  @override
  bool operator ==( other) =>
      identical(this, other) ||
      super == other &&
          other is Clinic &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          images == other.images &&
          phoneNumber == other.phoneNumber &&
          mobileNumber == other.mobileNumber &&
          level == other.level &&
          availabilityRange == other.availabilityRange &&
          distance == other.distance &&
          available == other.available &&
          featured == other.featured &&
          address == other.address &&
          rate == other.rate &&
          reviews == other.reviews &&
          totalReviews == other.totalReviews &&
          verified == other.verified &&
          doctors == other.doctors &&
          total_appointments == other.total_appointments;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      images.hashCode ^
      phoneNumber.hashCode ^
      mobileNumber.hashCode ^
      level.hashCode ^
      availabilityRange.hashCode ^
      distance.hashCode ^
      available.hashCode ^
      featured.hashCode ^
      address.hashCode ^
      rate.hashCode ^
      reviews.hashCode ^
      totalReviews.hashCode ^
      verified.hashCode ^
      doctors.hashCode ^
      total_appointments.hashCode;
}
