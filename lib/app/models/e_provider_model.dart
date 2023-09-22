/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'address_model.dart';
import 'availability_hour_model.dart';
import 'e_provider_type_model.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'review_model.dart';
import 'tax_model.dart';
import 'user_model.dart';

class EProvider extends Model {
  String? id;
  String? name;
  String? description;
  List<Media>? images;
  String? phoneNumber;
  String? mobileNumber;
  EProviderType? type;
  List<AvailabilityHour>? availabilityHours;
  double? availabilityRange;
  bool? available;
  bool? featured;
  List<Address>? addresses;
  List<Tax>? taxes;

  List<User>? employees;
  double? rate;
  List<Review>? reviews;
  int? totalReviews;
  bool? verified;
  int? bookingsInProgress;

  EProvider(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.phoneNumber,
      this.mobileNumber,
      this.type,
      this.availabilityHours,
      this.availabilityRange,
      this.available,
      this.featured,
      this.addresses,
      this.employees,
      this.rate,
      this.reviews,
      this.totalReviews,
      this.verified,
      this.bookingsInProgress});

  EProvider.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    if(json["name"]!=null)name = transStringFromJson(json, 'name');
    if(json["description"]!=null)description = transStringFromJson(json, 'description');
    if(json["images"]!=null)images = mediaListFromJson(json, 'images');
    if(json["phone_number"]!=null)phoneNumber = stringFromJson(json, 'phone_number');
    if(json["mobile_number"]!=null)mobileNumber = stringFromJson(json, 'mobile_number');
    if(json["e_provider_type"]!=null)type = (json['e_provider_type']!=null)?objectFromJson(json, 'e_provider_type', (v) => EProviderType.fromJson(v)):null;
    if(json["availability_hours"]!=null)availabilityHours = (json['availability_hours']!=null)?listFromJson(json, 'availability_hours', (v) => AvailabilityHour.fromJson(v)):null;
    if(json["availability_range"]!=null)availabilityRange = doubleFromJson(json, 'availability_range');
    if(json["available"]!=null)available = boolFromJson(json, 'available');
    if(json["featured"]!=null)featured = boolFromJson(json, 'featured');
    if(json["address"]!=null)addresses =  (json['address']!=null)?listFromJson(json, 'address', (v) => Address.fromJson(v)):null;
    if(json["taxes"]!=null)taxes =  (json['taxes']!=null)?listFromJson(json, 'taxes', (v) => Tax.fromJson(v)):null;
    if(json["users"]!=null)employees = (json['users']!=null)?listFromJson(json, 'users', (v) => User.fromJson(v)):null;
    if(json["rate"]!=null)rate = doubleFromJson(json, 'rate');
    if(json["e_provider_reviews"]!=null)reviews = (json['e_provider_reviews']!=null)?listFromJson(json, 'e_provider_reviews', (v) => Review.fromJson(v)):null;
    if(json["total_reviews"]!=null)totalReviews = reviews!.isEmpty ? intFromJson(json, 'total_reviews') : reviews!.length;
    if(json["verified"]!=null)verified = boolFromJson(json, 'verified');
    if(json["bookings_in_progress"]!=null)bookingsInProgress = intFromJson(json, 'bookings_in_progress');
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
    data['bookings_in_progress'] = this.bookingsInProgress;
    return data;
  }

  String get firstImageUrl => this.images?.first?.url ?? '';

  String get firstImageThumb => this.images?.first?.thumb ?? '';

  String get firstImageIcon => this.images?.first?.icon ?? '';

  String? get firstAddress {
    if (this.addresses!.isNotEmpty) {
      return this.addresses!.first.address!;
    }
    return '';
  }

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  Map<String, List<String>> groupedAvailabilityHours() {
    Map<String, List<String>>? result = {};
    this.availabilityHours!.forEach((element) {
      if (result.containsKey(element.day)) {
        result[element.day]!.add(element.startAt! + ' - ' + element.endAt!);
      } else {
        result[element.day!] = [element.startAt! + ' - ' + element.endAt!];
      }
    });
    return result;
  }

  List<String> getAvailabilityHoursData(String? day) {
    List<String> result = [];
    this.availabilityHours!.forEach((element) {
      if (element.day == day) {
        result.add(element.data!);
      }
    });
    return result;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is EProvider &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          images == other.images &&
          phoneNumber == other.phoneNumber &&
          mobileNumber == other.mobileNumber &&
          type == other.type &&
          availabilityRange == other.availabilityRange &&
          available == other.available &&
          featured == other.featured &&
          addresses == other.addresses &&
          rate == other.rate &&
          reviews == other.reviews &&
          totalReviews == other.totalReviews &&
          verified == other.verified &&
          bookingsInProgress == other.bookingsInProgress;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      images.hashCode ^
      phoneNumber.hashCode ^
      mobileNumber.hashCode ^
      type.hashCode ^
      availabilityRange.hashCode ^
      available.hashCode ^
      featured.hashCode ^
      addresses.hashCode ^
      rate.hashCode ^
      reviews.hashCode ^
      totalReviews.hashCode ^
      verified.hashCode ^
      bookingsInProgress.hashCode;
}
