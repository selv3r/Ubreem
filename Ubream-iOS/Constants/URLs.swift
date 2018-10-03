//
//  URLs.swift
//  Ubreem-iOS
//
//  Created by Hassan Ashraf on 17/9/18.
//  Copyright © 2018 Hassan Ashraf. All rights reserved.
//

import Foundation

struct URLs {
    
    static let baseUrl = "https://ubreem.intcore.net/"
    static let apiUrl = baseUrl + "api/v1/"
    
    //Authentication
    static let getCountries = apiUrl + "user/auth/country-list"
    static let checkPhone = apiUrl + "user/auth/valid-phone"
    static let signUp = apiUrl + "user/auth/signup"
    static let activateUserAccount = apiUrl + "user/auth/active-account"
    static let sendCodeAgain = apiUrl + "user/auth/resend-activation-code"
    static let login = apiUrl + "user/auth/signin"
    static let forgotPassword = apiUrl + "user/auth/password/email"
    static let resetPassword = apiUrl + "user/auth/password/reset"
    static let updateProfile = apiUrl + "user/auth/update-profile"
    static let getDataForOrder = apiUrl + "user/app/order/create"
    static let getDataForAddress = apiUrl + "user/app/address/create"
    static let addAddress = apiUrl + "user/app/address"
    static let getAddresses = apiUrl + "user/app/address"
    static let addNewOrder = apiUrl + "user/app/order"

    
    static let imageUrl = "https://ubreem.intcore.net/"
    static let uploadFile = apiUrl + "user/app/file/upload"

    // Registration Stuff .... for sign in, sign up , forgent, reset ......
//    static let phone = apiUrl + "user/auth/valid-phone"
//    static let country = apiUrl + "user/auth/country-list"
//    static let signin = apiUrl + "user/auth/signin"
//    static let resetpass = apiUrl + "user/auth/password/email"
//    static let newPass = apiUrl + "user/auth/password/reset"
//    static let register = apiUrl + "user/auth/signup"
//    // Profile
//    static let getProfile = apiUrl + "user/auth/get-profile"
//    static let getOtherProfile = apiUrl + "user/app/user/"
//    static let updateProfile = apiUrl + "user/auth/update-profile"
//    static let requestUpdatePhone = apiUrl + "user/auth/request-update-phone"
//    static let updatePhone = apiUrl + "user/auth/update-phone"
//    static let blockUser = apiUrl + "user/app/block-people"
//    static let viewAnotherUser = apiUrl + "user/app/user"
//    static let AnyProfile = apiUrl + "user/app/user/"
//    static let uploadFile = apiUrl + "user/app/file/upload"
//    static let updateLocation = apiUrl + "user/auth/update-location"
//
//    static let myBlockList = apiUrl + "user/app/block-people"
//    static let unBlockUser = apiUrl + "user/app/block-people/"
//
//
//    // Home
//    static let fetchNearbyCars = apiUrl + "user/app/home"
//
//    // Favorites
//    static let addOrRemoveFavorites = apiUrl + "user/app/favourite"
//    static let getFavoritesList = apiUrl + "user/app/favourite"
//
//    static let rateUser = apiUrl + "user/app/users/rate/"  //+ id
//
//    //AddCar
//    static let carPopups = apiUrl + "user/app/car/create"
//    static let addCar = apiUrl + "user/app/car"
//    static let getMyCars = apiUrl + "user/app/car"
//    static let deleteCar = apiUrl + "user/app/car/" // id
//    static let trackCarLocation = apiUrl + "user/app/car/actions/track"
//    // Add Interest
//    static let interestPopups = apiUrl + "user/app/interest/create"
//    static let AddInterest = apiUrl + "user/app/interest"
//    static let getInterests = apiUrl + "user/app/interest"
//    static let deleteInterest = apiUrl + "user/app/interest/" // id
//    //swear api
//    static let swear = apiUrl + "user/app/settings/swear"
//    // expired cars
//    static let expiredCarsList = apiUrl + "user/app/car/actions/expired-cars"
//    static let renewAd = apiUrl + "user/app/car/actions/renew-car/" // car_id
//    static let vip = apiUrl + "user/app/request/vip"
//    static let untracked = apiUrl + "user/app/car/untracked"
//    static let coupon = apiUrl + "user/app/coupons"
//    static let payment = apiUrl + "user/app/car/payment-history"
//    static let getFiltrationDara = apiUrl + "user/app/filter-map"
//    static let filteredExplore = apiUrl + "user/app/filter-explore"
//    static let search = apiUrl + "user/app/search"
//    static let map = apiUrl + "user/app/home"
//    // chat api
//    static let inbox = apiUrl + "user/app/chat/chat"
//    static let room = apiUrl + "user/app/chat/chat/" // user_id
//    static let lastMessages =  apiUrl + "user/app/chat/" //user/app/chat/55/messages/2326
//    static let reportUser = apiUrl + "user/app/report-user"
//
//    static let feedback = apiUrl + "user/app/feedback/create" // get req data
//    static let feedbackUpload = apiUrl + "user/app/feedback"
//    static let contactus = apiUrl + "user/app/contact-us"
//    static let requestHotzone = apiUrl + "user/app/request/hotzone"
//    static let verifyLetter = apiUrl + "user/app/send/verification-letter"
//    static let searchUserProfile = apiUrl + "user/app/search-user"
//    static let notification = apiUrl + "user/auth/notifications"
//    static let seen = apiUrl + "user/app/car/"
//    static let settings = apiUrl + "user/app/settings"
//    static let skipPayment = apiUrl + "user/app/car/actions/skip-payment/"
//    static let notSeen = apiUrl + "user/auth/notifications/"
//    static let getCar = apiUrl + "user/app/car/"
//    static let notSettings = apiUrl + "user/app/users/setting"
//    static let updatePassword = apiUrl + "user/auth/update-password"
//    static let getSurvey = apiUrl + "user/app/survey"
//    static let survey = apiUrl + "user/app/survey"
//    static let language = apiUrl + "user/auth/language"
//    static let requestAds = apiUrl + "user/app/request/ads"
//    static let myLocationTracking = apiUrl + "user/app/user-move"
    
}

