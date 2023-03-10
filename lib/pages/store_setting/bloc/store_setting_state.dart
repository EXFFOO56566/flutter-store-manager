part of 'store_setting_bloc.dart';

class StoreSettingState extends BaseState {
  //Single step
  final BaseState submitPolicyStatus;
  final BaseState submitSeoStatus;
  final BaseState submitSupportStatus;
  final BaseState submitSocialStatus;
  //--Multi step--//
  final StoreModel? storeSetting;
  final BaseState getStoreSettingStatus;
  final BaseState submitMultiStepStatus;
  //--General setting--//
  /// Form data status
  final FormzStatus statusSaveSetting;

  ///field
  final StoreName storeName;
  final StoreEmail storeEmail;
  final String? storePhone;
  final String? storeDescription;

  ///image
  final Image storeLogoImage;
  final Image storeBannerImage;
  final Image storeMobileBannerImage;

  //--Update payment--//
  /// Form data status
  final FormzStatus statusUpdatePayment;

  ///field
  final String? paymentMethod;
  final String? emailPaypal;
  final String? bankAccountName;
  final String? bankAccountNumber;
  final String? bankName;
  final String? bankState;
  final String? routingNum;
  final String? iBAN;
  final String? swiftCode;
  final String? ifscCode;

  //--1.Setup Store--//
  ///location
  final List<Prediction>? listPredictionLocation;
  final bool showPredictLocation;
  final String? keywordLocation;
  final UserLocation? userLocationFromId;
  final String? storeAddress1;
  final String? storeAddress2;
  final String? storeCityTown;
  final String? postZipCode;
  final String? storeCountry;

  //--3.Policy Setup--//
  final String? policyTab;
  final String? shippingPolicy;
  final String? refundPolicy;
  final String? cancelPolicy;

  //--4.Support Setup--//
  final String? supportPhone;
  final String? supportEmail;

  //--5.SEO Setup--//
  final String? seoTitle;
  final String? metaDes;
  final String? metaKey;
  final String? facebookTitle;
  final String? facebookDes;
  final String? twitterTitle;
  final String? twitterDes;
  final Image facebookImage;
  final Image twitterImage;

  //--6.SEO Setup--//
  final String? twitterLink;
  final String? facebookLink;
  final String? instaLink;
  final String? youtubeLink;
  final String? likedinLink;
  final String? googleLink;
  final String? snapLink;
  final String? pinterLink;

  const StoreSettingState({
    this.submitPolicyStatus = const InitState(),
    this.submitSeoStatus = const InitState(),
    this.submitSocialStatus = const InitState(),
    this.submitSupportStatus = const InitState(),
    this.storeSetting,
    this.getStoreSettingStatus = const InitState(),
    this.submitMultiStepStatus = const InitState(),
    this.statusSaveSetting = FormzStatus.valid,
    this.storeName = const StoreName.pure(),
    this.storeEmail = const StoreEmail.pure(),
    this.storePhone,
    this.storeDescription,
    this.paymentMethod,
    this.emailPaypal,
    this.bankAccountName,
    this.bankAccountNumber,
    this.bankName,
    this.bankState,
    this.routingNum,
    this.iBAN,
    this.swiftCode,
    this.ifscCode,
    this.statusUpdatePayment = FormzStatus.valid,
    this.storeLogoImage = const Image.pure(),
    this.storeBannerImage = const Image.pure(),
    this.storeMobileBannerImage = const Image.pure(),
    this.facebookImage = const Image.pure(),
    this.twitterImage = const Image.pure(),
    this.listPredictionLocation,
    this.showPredictLocation = false,
    this.keywordLocation,
    this.userLocationFromId,
    this.storeAddress1,
    this.storeAddress2,
    this.storeCityTown,
    this.postZipCode,
    this.storeCountry,
    this.policyTab,
    this.shippingPolicy,
    this.refundPolicy,
    this.cancelPolicy,
    this.supportPhone,
    this.supportEmail,
    this.seoTitle,
    this.metaDes,
    this.metaKey,
    this.facebookTitle,
    this.facebookDes,
    this.twitterTitle,
    this.twitterDes,
    this.twitterLink,
    this.facebookLink,
    this.instaLink,
    this.youtubeLink,
    this.likedinLink,
    this.googleLink,
    this.snapLink,
    this.pinterLink,
  });

  @override
  List<Object?> get props => [
        submitSupportStatus,
        submitSocialStatus,
        submitSeoStatus,
        submitPolicyStatus,
        storeSetting,
        getStoreSettingStatus,
        submitMultiStepStatus,
        storeName,
        storeEmail,
        statusSaveSetting,
        storePhone,
        storeDescription,
        paymentMethod,
        emailPaypal,
        bankAccountName,
        bankAccountNumber,
        bankName,
        bankState,
        routingNum,
        iBAN,
        swiftCode,
        ifscCode,
        statusUpdatePayment,
        storeLogoImage,
        storeBannerImage,
        storeMobileBannerImage,
        facebookImage,
        twitterImage,
        listPredictionLocation,
        showPredictLocation,
        keywordLocation,
        userLocationFromId,
        storeAddress1,
        storeAddress2,
        storeCityTown,
        postZipCode,
        storeCountry,
        policyTab,
        shippingPolicy,
        refundPolicy,
        cancelPolicy,
        supportPhone,
        supportEmail,
        seoTitle,
        metaDes,
        metaKey,
        facebookTitle,
        facebookDes,
        twitterTitle,
        twitterDes,
        twitterLink,
        facebookLink,
        instaLink,
        youtubeLink,
        likedinLink,
        googleLink,
        snapLink,
        pinterLink,
      ];

  StoreSettingState copyWith({
    BaseState? submitPolicyStatus,
    BaseState? submitSeoStatus,
    BaseState? submitSupportStatus,
    BaseState? submitSocialStatus,
    StoreModel? storeSetting,
    BaseState? getStoreSettingStatus,
    BaseState? submitMultiStepStatus,
    FormzStatus? statusSaveSetting,
    StoreName? storeName,
    StoreEmail? storeEmail,
    String? storePhone,
    String? storeDescription,
    String? paymentMethod,
    String? emailPaypal,
    String? bankAccountName,
    String? bankAccountNumber,
    String? bankName,
    String? bankState,
    String? routingNum,
    String? iBAN,
    String? swiftCode,
    String? ifscCode,
    FormzStatus? statusUpdatePayment,
    Image? storeLogoImage,
    Image? storeBannerImage,
    Image? storeMobileBannerImage,
    Image? facebookImage,
    Image? twitterImage,
    List<Prediction>? listPredictionLocation,
    bool? showPredictLocation,
    String? keywordLocation,
    UserLocation? userLocationFromId,
    String? storeAddress1,
    String? storeAddress2,
    String? storeCityTown,
    String? postZipCode,
    String? storeCountry,
    BaseState? submitStep1Status,
    BaseState? submitStep2Status,
    String? policyTab,
    String? shippingPolicy,
    String? refundPolicy,
    String? cancelPolicy,
    BaseState? submitStep3Status,
    String? supportPhone,
    String? supportEmail,
    BaseState? submitStep4Status,
    String? seoTitle,
    String? metaDes,
    String? metaKey,
    String? facebookTitle,
    String? facebookDes,
    String? twitterTitle,
    String? twitterDes,
    BaseState? submitStep5Status,
    String? twitterLink,
    String? facebookLink,
    String? instaLink,
    String? youtubeLink,
    String? likedinLink,
    String? googleLink,
    String? snapLink,
    String? pinterLink,
    BaseState? submitStep6Status,
  }) {
    return StoreSettingState(
      submitPolicyStatus: submitPolicyStatus ?? this.submitPolicyStatus,
      submitSeoStatus: submitSeoStatus ?? this.submitSeoStatus,
      submitSocialStatus: submitSocialStatus ?? this.submitSocialStatus,
      submitSupportStatus: submitSupportStatus ?? this.submitSupportStatus,
      storeSetting: storeSetting ?? this.storeSetting,
      getStoreSettingStatus: getStoreSettingStatus ?? this.getStoreSettingStatus,
      submitMultiStepStatus: submitMultiStepStatus ?? this.submitMultiStepStatus,
      statusSaveSetting: statusSaveSetting ?? this.statusSaveSetting,
      storeName: storeName ?? this.storeName,
      storeEmail: storeEmail ?? this.storeEmail,
      storePhone: storePhone ?? this.storePhone,
      storeDescription: storeDescription ?? this.storeDescription,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      emailPaypal: emailPaypal ?? this.emailPaypal,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankName: bankName ?? this.bankName,
      bankState: bankState ?? this.bankState,
      routingNum: routingNum ?? this.routingNum,
      iBAN: iBAN ?? this.iBAN,
      swiftCode: swiftCode ?? this.swiftCode,
      ifscCode: ifscCode ?? this.ifscCode,
      statusUpdatePayment: statusUpdatePayment ?? this.statusUpdatePayment,
      storeLogoImage: storeLogoImage ?? this.storeLogoImage,
      storeBannerImage: storeBannerImage ?? this.storeBannerImage,
      storeMobileBannerImage: storeMobileBannerImage ?? this.storeMobileBannerImage,
      facebookImage: facebookImage ?? this.facebookImage,
      twitterImage: twitterImage ?? this.twitterImage,
      listPredictionLocation: listPredictionLocation ?? this.listPredictionLocation,
      showPredictLocation: showPredictLocation ?? this.showPredictLocation,
      keywordLocation: keywordLocation ?? this.keywordLocation,
      userLocationFromId: userLocationFromId ?? this.userLocationFromId,
      storeAddress1: storeAddress1 ?? this.storeAddress1,
      storeAddress2: storeAddress2 ?? this.storeAddress2,
      storeCityTown: storeCityTown ?? this.storeCityTown,
      postZipCode: postZipCode ?? this.postZipCode,
      storeCountry: storeCountry ?? this.storeCountry,
      policyTab: policyTab ?? this.policyTab,
      shippingPolicy: shippingPolicy ?? this.shippingPolicy,
      refundPolicy: refundPolicy ?? this.refundPolicy,
      cancelPolicy: cancelPolicy ?? this.cancelPolicy,
      supportPhone: supportPhone ?? this.supportPhone,
      supportEmail: supportEmail ?? this.supportEmail,
      seoTitle: seoTitle ?? this.seoTitle,
      metaDes: metaDes ?? this.metaDes,
      metaKey: metaKey ?? this.metaKey,
      facebookTitle: facebookTitle ?? this.facebookTitle,
      facebookDes: facebookDes ?? this.facebookDes,
      twitterTitle: twitterTitle ?? this.twitterTitle,
      twitterDes: twitterDes ?? this.twitterDes,
      twitterLink: twitterLink ?? this.twitterLink,
      facebookLink: facebookLink ?? this.facebookLink,
      instaLink: instaLink ?? this.instaLink,
      youtubeLink: youtubeLink ?? this.youtubeLink,
      likedinLink: likedinLink ?? this.likedinLink,
      googleLink: googleLink ?? this.googleLink,
      snapLink: snapLink ?? this.snapLink,
      pinterLink: pinterLink ?? this.pinterLink,
    );
  }
}
