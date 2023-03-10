import 'package:example/utils/utils.dart';

class StoreModel {
  String? storeSlug;
  String? bannerType;
  String? bannerVideo;
  List<BannerSlider>? bannerSlider;
  String? listBannerType;
  String? listBanner;
  String? listBannerVideo;
  String? storeNamePosition;
  String? storePpp;
  Address? address;
  Geolocation? geolocation;
  WcfmmpShipping? wcfmmpShipping;
  WcfmmpShippingByCountry? wcfmmpShippingByCountry;
  List<WcfmmpShippingRates>? wcfmmpShippingRates;
  WcfmmpShippingByWeight? wcfmmpShippingByWeight;
  List<WcfmmpShippingRatesByWeight>? wcfmmpShippingRatesByWeight;
  StoreSeo? storeSeo;
  String? wcfmPolicyTabTitle;
  String? wcfmShippingPolicy;
  String? wcfmRefundPolicy;
  String? wcfmCancellationPolicy;
  CustomerSupport? customerSupport;
  String? wcfmVacationModeType;
  String? wcfmVacationStartDate;
  String? wcfmVacationEndDate;
  String? wcfmVacationModeMsg;
  String? wcfmNonce;
  String? storeHideEmail;
  String? storeHidePhone;
  String? storeHideAddress;
  String? storeHideMap;
  String? storeHideDescription;
  String? storeHidePolicy;
  String? wcfmVacationMode;
  String? wcfmDisableVacationPurchase;
  String? findAddress;
  String? storeLocation;
  String? storeLat;
  String? storeLng;
  String? storeEmail;
  String? phone;
  String? methodStatus;
  String? methodIdSelected;
  String? instanceIdSelected;
  String? methodTitle;
  String? minimumOrderAmount;
  String? methodDescription;
  String? methodCost;
  String? methodTaxStatus;
  String? calculationType;
  String? storeName;
  int? mobileBanner;
  String? vendorId;
  String? shopDescription;
  Payment? payment;
  int? gravatar;
  int? banner;
  String? gravatarSrc;
  String? bannerSrc;
  String? mobileBannerSrc;
  Social? social;

  StoreModel({
    this.storeSlug,
    this.bannerType,
    this.bannerVideo,
    this.bannerSlider,
    this.listBannerType,
    this.listBanner,
    this.listBannerVideo,
    this.storeNamePosition,
    this.storePpp,
    this.address,
    this.geolocation,
    this.wcfmmpShipping,
    this.wcfmmpShippingByCountry,
    this.wcfmmpShippingRates,
    this.wcfmmpShippingByWeight,
    this.wcfmmpShippingRatesByWeight,
    this.storeSeo,
    this.wcfmPolicyTabTitle,
    this.wcfmShippingPolicy,
    this.wcfmRefundPolicy,
    this.wcfmCancellationPolicy,
    this.customerSupport,
    this.wcfmVacationModeType,
    this.wcfmVacationStartDate,
    this.wcfmVacationEndDate,
    this.wcfmVacationModeMsg,
    this.wcfmNonce,
    this.storeHideEmail,
    this.storeHidePhone,
    this.storeHideAddress,
    this.storeHideMap,
    this.storeHideDescription,
    this.storeHidePolicy,
    this.wcfmVacationMode,
    this.wcfmDisableVacationPurchase,
    this.findAddress,
    this.storeLocation,
    this.storeLat,
    this.storeLng,
    this.storeEmail,
    this.phone,
    this.methodStatus,
    this.methodIdSelected,
    this.instanceIdSelected,
    this.methodTitle,
    this.minimumOrderAmount,
    this.methodDescription,
    this.methodCost,
    this.methodTaxStatus,
    this.calculationType,
    this.storeName,
    this.mobileBanner,
    this.vendorId,
    this.shopDescription,
    this.payment,
    this.gravatar,
    this.banner,
    this.gravatarSrc,
    this.bannerSrc,
    this.mobileBannerSrc,
    this.social,
  });

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeSlug = json['store_slug'];
    bannerType = json['banner_type'];
    bannerVideo = json['banner_video'];
    if (json['banner_slider'] != null) {
      bannerSlider = <BannerSlider>[];
      json['banner_slider'].forEach((v) {
        bannerSlider!.add(BannerSlider.fromJson(v));
      });
    }
    listBannerType = json['list_banner_type'];
    listBanner = json['list_banner'];
    listBannerVideo = json['list_banner_video'];
    storeNamePosition = json['store_name_position'];
    storePpp = json['store_ppp'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    geolocation = json['geolocation'] != null ? Geolocation.fromJson(json['geolocation']) : null;
    wcfmmpShipping = json['wcfmmp_shipping'] != null ? WcfmmpShipping.fromJson(json['wcfmmp_shipping']) : null;
    wcfmmpShippingByCountry = json['wcfmmp_shipping_by_country'] != null
        ? WcfmmpShippingByCountry.fromJson(json['wcfmmp_shipping_by_country'])
        : null;
    if (json['wcfmmp_shipping_rates'] != null) {
      wcfmmpShippingRates = <WcfmmpShippingRates>[];
      json['wcfmmp_shipping_rates'].forEach((v) {
        wcfmmpShippingRates!.add(WcfmmpShippingRates.fromJson(v));
      });
    }
    wcfmmpShippingByWeight = json['wcfmmp_shipping_by_weight'] != null
        ? WcfmmpShippingByWeight.fromJson(json['wcfmmp_shipping_by_weight'])
        : null;
    if (json['wcfmmp_shipping_rates_by_weight'] != null) {
      wcfmmpShippingRatesByWeight = <WcfmmpShippingRatesByWeight>[];
      json['wcfmmp_shipping_rates_by_weight'].forEach((v) {
        wcfmmpShippingRatesByWeight!.add(WcfmmpShippingRatesByWeight.fromJson(v));
      });
    }
    storeSeo = json['store_seo'] != null ? StoreSeo.fromJson(json['store_seo']) : null;
    wcfmPolicyTabTitle = json['wcfm_policy_tab_title'];
    wcfmShippingPolicy = json['wcfm_shipping_policy'];
    wcfmRefundPolicy = json['wcfm_refund_policy'];
    wcfmCancellationPolicy = json['wcfm_cancellation_policy'];
    customerSupport = json['customer_support'] != null ? CustomerSupport.fromJson(json['customer_support']) : null;
    wcfmVacationModeType = json['wcfm_vacation_mode_type'];
    wcfmVacationStartDate = json['wcfm_vacation_start_date'];
    wcfmVacationEndDate = json['wcfm_vacation_end_date'];
    wcfmVacationModeMsg = json['wcfm_vacation_mode_msg'];
    wcfmNonce = json['wcfm_nonce'];
    storeHideEmail = json['store_hide_email'];
    storeHidePhone = json['store_hide_phone'];
    storeHideAddress = json['store_hide_address'];
    storeHideMap = json['store_hide_map'];
    storeHideDescription = json['store_hide_description'];
    storeHidePolicy = json['store_hide_policy'];
    wcfmVacationMode = json['wcfm_vacation_mode'];
    wcfmDisableVacationPurchase = json['wcfm_disable_vacation_purchase'];
    findAddress = json['find_address'];
    storeLocation = json['store_location'];
    storeLat = json['store_lat'];
    storeLng = json['store_lng'];
    storeEmail = json['store_email'];
    phone = json['phone'];
    methodStatus = json['method_status'];
    methodIdSelected = json['method_id_selected'];
    instanceIdSelected = json['instance_id_selected'];
    methodTitle = json['method_title'];
    minimumOrderAmount = json['minimum_order_amount'];
    methodDescription = json['method_description'];
    methodCost = json['method_cost'];
    methodTaxStatus = json['method_tax_status'];
    calculationType = json['calculation_type'];
    storeName = json['store_name'];
    mobileBanner = ConvertData.stringToInt(json['mobile_banner']);
    vendorId = json['vendor_id'];
    shopDescription = json['shop_description'];
    payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    gravatar = ConvertData.stringToInt(json['gravatar']);
    banner = ConvertData.stringToInt(json['banner']);
    gravatarSrc = json['gravatar_src'];
    bannerSrc = json['banner_src'];
    mobileBannerSrc = json['mobile_banner_src'];
    social = json['social'] != null ? Social.fromJson(json['social']) : null;
  }
}

class BannerSlider {
  String? image;
  String? link;

  BannerSlider({this.image, this.link});

  BannerSlider.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['link'] = link;
    return data;
  }
}

class Address {
  String? street1;
  String? street2;
  String? city;
  String? zip;
  String? country;
  String? state;

  Address({this.street1, this.street2, this.city, this.zip, this.country, this.state});

  Address.fromJson(Map<String, dynamic> json) {
    street1 = json['street_1'];
    street2 = json['street_2'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street_1'] = street1;
    data['street_2'] = street2;
    data['city'] = city;
    data['zip'] = zip;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}

class Geolocation {
  String? findAddress;
  String? storeLocation;
  String? storeLat;
  String? storeLng;

  Geolocation({this.findAddress, this.storeLocation, this.storeLat, this.storeLng});

  Geolocation.fromJson(Map<String, dynamic> json) {
    findAddress = json['find_address'];
    storeLocation = json['store_location'];
    storeLat = json['store_lat'];
    storeLng = json['store_lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['find_address'] = findAddress;
    data['store_location'] = storeLocation;
    data['store_lat'] = storeLat;
    data['store_lng'] = storeLng;
    return data;
  }
}

class WcfmmpShipping {
  String? sWcfmmpUserShippingEnable;
  String? sWcfmmpPt;
  String? sWcfmmpUserShippingType;

  WcfmmpShipping({this.sWcfmmpUserShippingEnable, this.sWcfmmpPt, this.sWcfmmpUserShippingType});

  WcfmmpShipping.fromJson(Map<String, dynamic> json) {
    sWcfmmpUserShippingEnable = json['_wcfmmp_user_shipping_enable'];
    sWcfmmpPt = json['_wcfmmp_pt'];
    sWcfmmpUserShippingType = json['_wcfmmp_user_shipping_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_wcfmmp_user_shipping_enable'] = sWcfmmpUserShippingEnable;
    data['_wcfmmp_pt'] = sWcfmmpPt;
    data['_wcfmmp_user_shipping_type'] = sWcfmmpUserShippingType;
    return data;
  }
}

class WcfmmpShippingByCountry {
  String? sWcfmmpShippingTypePrice;
  String? sWcfmmpAdditionalProduct;
  String? sWcfmmpAdditionalQty;
  String? sFreeShippingAmount;
  String? sLocalPickupCost;
  String? sWcfmmpFormLocation;

  WcfmmpShippingByCountry(
      {this.sWcfmmpShippingTypePrice,
      this.sWcfmmpAdditionalProduct,
      this.sWcfmmpAdditionalQty,
      this.sFreeShippingAmount,
      this.sLocalPickupCost,
      this.sWcfmmpFormLocation});

  WcfmmpShippingByCountry.fromJson(Map<String, dynamic> json) {
    sWcfmmpShippingTypePrice = json['_wcfmmp_shipping_type_price'];
    sWcfmmpAdditionalProduct = json['_wcfmmp_additional_product'];
    sWcfmmpAdditionalQty = json['_wcfmmp_additional_qty'];
    sFreeShippingAmount = json['_free_shipping_amount'];
    sLocalPickupCost = json['_local_pickup_cost'];
    sWcfmmpFormLocation = json['_wcfmmp_form_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_wcfmmp_shipping_type_price'] = sWcfmmpShippingTypePrice;
    data['_wcfmmp_additional_product'] = sWcfmmpAdditionalProduct;
    data['_wcfmmp_additional_qty'] = sWcfmmpAdditionalQty;
    data['_free_shipping_amount'] = sFreeShippingAmount;
    data['_local_pickup_cost'] = sLocalPickupCost;
    data['_wcfmmp_form_location'] = sWcfmmpFormLocation;
    return data;
  }
}

class WcfmmpShippingRates {
  String? wcfmmpCountryTo;
  String? wcfmmpCountryToPrice;
  List<WcfmmpShippingStateRates>? wcfmmpShippingStateRates;

  WcfmmpShippingRates({this.wcfmmpCountryTo, this.wcfmmpCountryToPrice, this.wcfmmpShippingStateRates});

  WcfmmpShippingRates.fromJson(Map<String, dynamic> json) {
    wcfmmpCountryTo = json['wcfmmp_country_to'];
    wcfmmpCountryToPrice = json['wcfmmp_country_to_price'];
    if (json['wcfmmp_shipping_state_rates'] != null) {
      wcfmmpShippingStateRates = <WcfmmpShippingStateRates>[];
      json['wcfmmp_shipping_state_rates'].forEach((v) {
        wcfmmpShippingStateRates!.add(WcfmmpShippingStateRates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wcfmmp_country_to'] = wcfmmpCountryTo;
    data['wcfmmp_country_to_price'] = wcfmmpCountryToPrice;
    if (wcfmmpShippingStateRates != null) {
      data['wcfmmp_shipping_state_rates'] = wcfmmpShippingStateRates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WcfmmpShippingStateRates {
  String? wcfmmpStateTo;
  String? wcfmmpStateToPrice;

  WcfmmpShippingStateRates({this.wcfmmpStateTo, this.wcfmmpStateToPrice});

  WcfmmpShippingStateRates.fromJson(Map<String, dynamic> json) {
    wcfmmpStateTo = json['wcfmmp_state_to'];
    wcfmmpStateToPrice = json['wcfmmp_state_to_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wcfmmp_state_to'] = wcfmmpStateTo;
    data['wcfmmp_state_to_price'] = wcfmmpStateToPrice;
    return data;
  }
}

class WcfmmpShippingByWeight {
  String? sFreeShippingAmount;
  String? sLocalPickupCost;

  WcfmmpShippingByWeight({this.sFreeShippingAmount, this.sLocalPickupCost});

  WcfmmpShippingByWeight.fromJson(Map<String, dynamic> json) {
    sFreeShippingAmount = json['_free_shipping_amount'];
    sLocalPickupCost = json['_local_pickup_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_free_shipping_amount'] = sFreeShippingAmount;
    data['_local_pickup_cost'] = sLocalPickupCost;
    return data;
  }
}

class WcfmmpShippingRatesByWeight {
  String? wcfmmpWeightwiseCountryTo;
  String? wcfmmpWeightwiseCountryMode;
  String? wcfmmpWeightwiseCountryPerUnitCost;
  String? wcfmmpWeightwiseCountryDefaultCost;
  List<WcfmmpShippingCountryWeightSettings>? wcfmmpShippingCountryWeightSettings;

  WcfmmpShippingRatesByWeight(
      {this.wcfmmpWeightwiseCountryTo,
      this.wcfmmpWeightwiseCountryMode,
      this.wcfmmpWeightwiseCountryPerUnitCost,
      this.wcfmmpWeightwiseCountryDefaultCost,
      this.wcfmmpShippingCountryWeightSettings});

  WcfmmpShippingRatesByWeight.fromJson(Map<String, dynamic> json) {
    wcfmmpWeightwiseCountryTo = json['wcfmmp_weightwise_country_to'];
    wcfmmpWeightwiseCountryMode = json['wcfmmp_weightwise_country_mode'];
    wcfmmpWeightwiseCountryPerUnitCost = json['wcfmmp_weightwise_country_per_unit_cost'];
    wcfmmpWeightwiseCountryDefaultCost = json['wcfmmp_weightwise_country_default_cost'];
    if (json['wcfmmp_shipping_country_weight_settings'] != null) {
      wcfmmpShippingCountryWeightSettings = <WcfmmpShippingCountryWeightSettings>[];
      json['wcfmmp_shipping_country_weight_settings'].forEach((v) {
        wcfmmpShippingCountryWeightSettings!.add(WcfmmpShippingCountryWeightSettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wcfmmp_weightwise_country_to'] = wcfmmpWeightwiseCountryTo;
    data['wcfmmp_weightwise_country_mode'] = wcfmmpWeightwiseCountryMode;
    data['wcfmmp_weightwise_country_per_unit_cost'] = wcfmmpWeightwiseCountryPerUnitCost;
    data['wcfmmp_weightwise_country_default_cost'] = wcfmmpWeightwiseCountryDefaultCost;
    if (wcfmmpShippingCountryWeightSettings != null) {
      data['wcfmmp_shipping_country_weight_settings'] =
          wcfmmpShippingCountryWeightSettings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WcfmmpShippingCountryWeightSettings {
  String? wcfmmpWeightRule;
  String? wcfmmpWeightUnit;
  String? wcfmmpWeightPrice;

  WcfmmpShippingCountryWeightSettings({this.wcfmmpWeightRule, this.wcfmmpWeightUnit, this.wcfmmpWeightPrice});

  WcfmmpShippingCountryWeightSettings.fromJson(Map<String, dynamic> json) {
    wcfmmpWeightRule = json['wcfmmp_weight_rule'];
    wcfmmpWeightUnit = json['wcfmmp_weight_unit'];
    wcfmmpWeightPrice = json['wcfmmp_weight_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wcfmmp_weight_rule'] = wcfmmpWeightRule;
    data['wcfmmp_weight_unit'] = wcfmmpWeightUnit;
    data['wcfmmp_weight_price'] = wcfmmpWeightPrice;
    return data;
  }
}

class StoreSeo {
  String? wcfmmpSeoMetaTitle;
  String? wcfmmpSeoMetaDesc;
  String? wcfmmpSeoMetaKeywords;
  String? wcfmmpSeoOgTitle;
  String? wcfmmpSeoOgDesc;
  int? wcfmmpSeoOgImage;
  String? wcfmmpSeoTwitterTitle;
  String? wcfmmpSeoTwitterDesc;
  int? wcfmmpSeoTwitterImage;
  String? wcfmmpSeoTwitterImageSrc;
  String? wcfmmpSeoOgImageSrc;

  StoreSeo(
      {this.wcfmmpSeoMetaTitle,
      this.wcfmmpSeoMetaDesc,
      this.wcfmmpSeoMetaKeywords,
      this.wcfmmpSeoOgTitle,
      this.wcfmmpSeoOgDesc,
      this.wcfmmpSeoOgImage,
      this.wcfmmpSeoTwitterTitle,
      this.wcfmmpSeoTwitterDesc,
      this.wcfmmpSeoTwitterImage,
      this.wcfmmpSeoOgImageSrc,
      this.wcfmmpSeoTwitterImageSrc});

  StoreSeo.fromJson(Map<String, dynamic> json) {
    wcfmmpSeoMetaTitle = json['wcfmmp-seo-meta-title'];
    wcfmmpSeoMetaDesc = json['wcfmmp-seo-meta-desc'];
    wcfmmpSeoMetaKeywords = json['wcfmmp-seo-meta-keywords'];
    wcfmmpSeoOgTitle = json['wcfmmp-seo-og-title'];
    wcfmmpSeoOgDesc = json['wcfmmp-seo-og-desc'];
    wcfmmpSeoOgImage = ConvertData.stringToInt(json['wcfmmp-seo-og-image']);
    wcfmmpSeoTwitterTitle = json['wcfmmp-seo-twitter-title'];
    wcfmmpSeoTwitterDesc = json['wcfmmp-seo-twitter-desc'];
    wcfmmpSeoTwitterImage = ConvertData.stringToInt(json['wcfmmp-seo-twitter-image']);
    wcfmmpSeoOgImageSrc = json['wcfmmp-seo-og-image-src'];
    wcfmmpSeoTwitterImageSrc = json['wcfmmp-seo-twitter-image-src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wcfmmp-seo-meta-title'] = wcfmmpSeoMetaTitle;
    data['wcfmmp-seo-meta-desc'] = wcfmmpSeoMetaDesc;
    data['wcfmmp-seo-meta-keywords'] = wcfmmpSeoMetaKeywords;
    data['wcfmmp-seo-og-title'] = wcfmmpSeoOgTitle;
    data['wcfmmp-seo-og-desc'] = wcfmmpSeoOgDesc;
    data['wcfmmp-seo-og-image'] = wcfmmpSeoOgImage;
    data['wcfmmp-seo-twitter-title'] = wcfmmpSeoTwitterTitle;
    data['wcfmmp-seo-twitter-desc'] = wcfmmpSeoTwitterDesc;
    data['wcfmmp-seo-twitter-image'] = wcfmmpSeoTwitterImage;
    data['wcfmmp-seo-og-image-src'] = wcfmmpSeoOgImageSrc;
    data['wcfmmp-seo-twitter-image-src'] = wcfmmpSeoTwitterImageSrc;
    return data;
  }
}

class CustomerSupport {
  String? phone;
  String? email;
  String? address1;
  String? address2;
  String? country;
  String? city;
  String? state;
  String? zip;

  CustomerSupport(
      {this.phone, this.email, this.address1, this.address2, this.country, this.city, this.state, this.zip});

  CustomerSupport.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    address1 = json['address1'];
    address2 = json['address2'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['email'] = email;
    data['address1'] = address1;
    data['address2'] = address2;
    data['country'] = country;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    return data;
  }
}

class Payment {
  String? method;
  Paypal? paypal;
  Paypal? skrill;
  Bank? bank;

  Payment({this.method, this.paypal, this.skrill, this.bank});

  Payment.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    paypal = json['paypal'] != null ? Paypal.fromJson(json['paypal']) : null;
    skrill = json['skrill'] != null ? Paypal.fromJson(json['skrill']) : null;
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    if (paypal != null) {
      data['paypal'] = paypal!.toJson();
    }
    if (skrill != null) {
      data['skrill'] = skrill!.toJson();
    }
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    return data;
  }
}

class Paypal {
  String? email;

  Paypal({this.email});

  Paypal.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

class Bank {
  String? acName;
  String? acNumber;
  String? bankName;
  String? bankAddr;
  String? routingNumber;
  String? iban;
  String? swift;
  String? ifsc;

  Bank(
      {this.acName, this.acNumber, this.bankName, this.bankAddr, this.routingNumber, this.iban, this.swift, this.ifsc});

  Bank.fromJson(Map<String, dynamic> json) {
    acName = json['ac_name'];
    acNumber = json['ac_number'];
    bankName = json['bank_name'];
    bankAddr = json['bank_addr'];
    routingNumber = json['routing_number'];
    iban = json['iban'];
    swift = json['swift'];
    ifsc = json['ifsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ac_name'] = acName;
    data['ac_number'] = acNumber;
    data['bank_name'] = bankName;
    data['bank_addr'] = bankAddr;
    data['routing_number'] = routingNumber;
    data['iban'] = iban;
    data['swift'] = swift;
    data['ifsc'] = ifsc;
    return data;
  }
}

class Social {
  String? twitter;
  String? fb;
  String? instagram;
  String? youtube;
  String? linkedin;
  String? gplus;
  String? snapchat;
  String? pinterest;
  String? googleplus;
  String? facebook;

  Social(
      {this.twitter,
      this.fb,
      this.instagram,
      this.youtube,
      this.linkedin,
      this.gplus,
      this.snapchat,
      this.pinterest,
      this.googleplus,
      this.facebook});

  Social.fromJson(Map<String, dynamic> json) {
    twitter = json['twitter'];
    fb = json['fb'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    linkedin = json['linkedin'];
    gplus = json['gplus'];
    snapchat = json['snapchat'];
    pinterest = json['pinterest'];
    googleplus = json['googleplus'];
    facebook = json['facebook'];
  }
}
