part of 'store_setting_bloc.dart';

abstract class StoreSettingEvent extends Equatable {
  const StoreSettingEvent();

  @override
  List<Object> get props => [];
}

class GetStoreSettingEvent extends StoreSettingEvent {
  const GetStoreSettingEvent();
}

//--General setting--//
///name
class StoreNameChanged extends StoreSettingEvent {
  const StoreNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

///email
class StoreEmailChanged extends StoreSettingEvent {
  const StoreEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

///phone
class StorePhoneChanged extends StoreSettingEvent {
  const StorePhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

///description
class StoreDescriptionChanged extends StoreSettingEvent {
  const StoreDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

///pick image logo
class StoreLogoChangedEvent extends StoreSettingEvent {
  const StoreLogoChangedEvent(this.image);

  final ImageData image;

  @override
  List<Object> get props => [image];
}

class StoreLogoDeletedEvent extends StoreSettingEvent {
  const StoreLogoDeletedEvent();
}

///pick image banner
class StoreBannerChangedEvent extends StoreSettingEvent {
  const StoreBannerChangedEvent(this.image);

  final ImageData image;

  @override
  List<Object> get props => [image];
}

class StoreBannerDeletedEvent extends StoreSettingEvent {
  const StoreBannerDeletedEvent();
}

///pick image mobile banner
class StoreMobileBannerChangedEvent extends StoreSettingEvent {
  const StoreMobileBannerChangedEvent(this.image);

  final ImageData image;

  @override
  List<Object> get props => [image];
}

class StoreMobileBannerDeletedEvent extends StoreSettingEvent {
  const StoreMobileBannerDeletedEvent();
}

//--Update payment--//
///method
class PaymentMethodChanged extends StoreSettingEvent {
  const PaymentMethodChanged(this.method);

  final String method;

  @override
  List<Object> get props => [method];
}

///emailPaypal
class PaymentEmailPaypalChanged extends StoreSettingEvent {
  const PaymentEmailPaypalChanged(this.emailPaypal);

  final String emailPaypal;

  @override
  List<Object> get props => [emailPaypal];
}

///bankAcName
class PaymentBankAcNameChanged extends StoreSettingEvent {
  const PaymentBankAcNameChanged(this.bankAcName);

  final String bankAcName;

  @override
  List<Object> get props => [bankAcName];
}

///bankAcNum
class PaymentBankAcNumChanged extends StoreSettingEvent {
  const PaymentBankAcNumChanged(this.bankAcNum);

  final String bankAcNum;

  @override
  List<Object> get props => [bankAcNum];
}

///bankName
class PaymentBankNameChanged extends StoreSettingEvent {
  const PaymentBankNameChanged(this.bankName);

  final String bankName;

  @override
  List<Object> get props => [bankName];
}

///bankState
class PaymentStateChanged extends StoreSettingEvent {
  const PaymentStateChanged(this.bankState);

  final String bankState;

  @override
  List<Object> get props => [bankState];
}

///bankRoutingNum
class PaymentBankRoutingNumChanged extends StoreSettingEvent {
  const PaymentBankRoutingNumChanged(this.bankRoutingNum);

  final String bankRoutingNum;

  @override
  List<Object> get props => [bankRoutingNum];
}

///bankIban
class PaymentBankIbanChanged extends StoreSettingEvent {
  const PaymentBankIbanChanged(this.bankIban);

  final String bankIban;

  @override
  List<Object> get props => [bankIban];
}

///bankSwiftCode
class PaymentBankSwiftCodeChanged extends StoreSettingEvent {
  const PaymentBankSwiftCodeChanged(this.bankSwiftCode);

  final String bankSwiftCode;

  @override
  List<Object> get props => [bankSwiftCode];
}

///bankIfscCode
class PaymentBankIfscCodeChanged extends StoreSettingEvent {
  const PaymentBankIfscCodeChanged(this.bankIfscCode);

  final String bankIfscCode;

  @override
  List<Object> get props => [bankIfscCode];
}

///update Payment
class UpdatePaymentMethod extends StoreSettingEvent {
  const UpdatePaymentMethod();
}

//--1.Setup Store--//
///location
class SearchLocationChangedEvent extends StoreSettingEvent {
  final String? keyword;
  const SearchLocationChangedEvent({required this.keyword});
}

class GetPlaceFromIdEvent extends StoreSettingEvent {
  final String? placeId;
  const GetPlaceFromIdEvent({required this.placeId});
}

class UpdateUserLocationEvent extends StoreSettingEvent {
  final UserLocation? userLocation;
  const UpdateUserLocationEvent({required this.userLocation});
}

///button
class SubmitStep1Event extends StoreSettingEvent {
  final Address address;
  final bool? isSingle;
  const SubmitStep1Event(this.address, {this.isSingle});
  @override
  List<Object> get props => [address];
}

//--2.Pay--//
class SubmitStep2Event extends StoreSettingEvent {
  const SubmitStep2Event({this.isSingle});
  final bool? isSingle;
}

//--3.Policy--//
class TabPolicyChanged extends StoreSettingEvent {
  const TabPolicyChanged(this.tabPolicy);

  final String tabPolicy;

  @override
  List<Object> get props => [tabPolicy];
}

class ShippingPolicyChanged extends StoreSettingEvent {
  const ShippingPolicyChanged(this.shippingPolicy);

  final String shippingPolicy;

  @override
  List<Object> get props => [shippingPolicy];
}

class RefundPolicyChanged extends StoreSettingEvent {
  const RefundPolicyChanged(this.refundPolicy);

  final String refundPolicy;

  @override
  List<Object> get props => [refundPolicy];
}

class CancelPolicyChanged extends StoreSettingEvent {
  const CancelPolicyChanged(this.cancelPolicy);

  final String cancelPolicy;

  @override
  List<Object> get props => [cancelPolicy];
}

class SubmitStep3Event extends StoreSettingEvent {
  const SubmitStep3Event({this.isSingle});
  final bool? isSingle;
}

//--4.Support--//
class SupportPhoneChanged extends StoreSettingEvent {
  const SupportPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class SupportEmailChanged extends StoreSettingEvent {
  const SupportEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SubmitStep4Event extends StoreSettingEvent {
  final Address address;
  final bool? isSingle;
  const SubmitStep4Event(this.address, {this.isSingle});
  @override
  List<Object> get props => [address];
}

//--5.Support--//
class SeoTitleChanged extends StoreSettingEvent {
  const SeoTitleChanged(this.seoTitle);

  final String seoTitle;

  @override
  List<Object> get props => [seoTitle];
}

class SeoDesChanged extends StoreSettingEvent {
  const SeoDesChanged(this.seoDes);

  final String seoDes;

  @override
  List<Object> get props => [seoDes];
}

class MetaKeyChanged extends StoreSettingEvent {
  const MetaKeyChanged(this.metaKey);

  final String metaKey;

  @override
  List<Object> get props => [metaKey];
}

class FacebookTitleChanged extends StoreSettingEvent {
  const FacebookTitleChanged(this.facebookTitle);

  final String facebookTitle;

  @override
  List<Object> get props => [facebookTitle];
}

class FacebookDesChanged extends StoreSettingEvent {
  const FacebookDesChanged(this.facebookDes);

  final String facebookDes;

  @override
  List<Object> get props => [facebookDes];
}

class FacebookImgChangedEvent extends StoreSettingEvent {
  const FacebookImgChangedEvent(this.image);

  final ImageData image;

  @override
  List<Object> get props => [image];
}

class FacebookImgDeletedEvent extends StoreSettingEvent {
  const FacebookImgDeletedEvent();
}

class TwitterTitleChanged extends StoreSettingEvent {
  const TwitterTitleChanged(this.twitterTitle);

  final String twitterTitle;

  @override
  List<Object> get props => [twitterTitle];
}

class TwitterDesChanged extends StoreSettingEvent {
  const TwitterDesChanged(this.twitterDes);

  final String twitterDes;

  @override
  List<Object> get props => [twitterDes];
}

class TwitterImgChangedEvent extends StoreSettingEvent {
  const TwitterImgChangedEvent(this.image);

  final ImageData image;

  @override
  List<Object> get props => [image];
}

class TwitterImgDeletedEvent extends StoreSettingEvent {
  const TwitterImgDeletedEvent();
}

class SubmitStep5Event extends StoreSettingEvent {
  const SubmitStep5Event({this.isSingle});
  final bool? isSingle;
}

//--5.Support--//
class TwitterLinkChanged extends StoreSettingEvent {
  const TwitterLinkChanged(this.twitterLink);

  final String twitterLink;

  @override
  List<Object> get props => [twitterLink];
}

class FacebookLinkChanged extends StoreSettingEvent {
  const FacebookLinkChanged(this.facebookLink);

  final String facebookLink;

  @override
  List<Object> get props => [facebookLink];
}

class InstaLinkChanged extends StoreSettingEvent {
  const InstaLinkChanged(this.instaLink);

  final String instaLink;

  @override
  List<Object> get props => [instaLink];
}

class YoutubeLinkChanged extends StoreSettingEvent {
  const YoutubeLinkChanged(this.youtubeLink);

  final String youtubeLink;

  @override
  List<Object> get props => [youtubeLink];
}

class LikedinLinkChanged extends StoreSettingEvent {
  const LikedinLinkChanged(this.likedinLink);

  final String likedinLink;

  @override
  List<Object> get props => [likedinLink];
}

class GoogleLinkChanged extends StoreSettingEvent {
  const GoogleLinkChanged(this.googleLink);

  final String googleLink;

  @override
  List<Object> get props => [googleLink];
}

class SnapLinkChanged extends StoreSettingEvent {
  const SnapLinkChanged(this.snapLink);

  final String snapLink;

  @override
  List<Object> get props => [snapLink];
}

class PinterLinkChanged extends StoreSettingEvent {
  const PinterLinkChanged(this.pinterLink);

  final String pinterLink;

  @override
  List<Object> get props => [pinterLink];
}

class SubmitStep6Event extends StoreSettingEvent {
  const SubmitStep6Event({this.isSingle});
  final bool? isSingle;
}

///multi Step
class SubmitMultiStepEvent extends StoreSettingEvent {
  const SubmitMultiStepEvent();
}
