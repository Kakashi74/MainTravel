//
//  Constants.swift
//  MainTravel
//
//  Created by Ahmed on 11/29/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import Foundation
import UIKit

/// Base_URL
let BASE_URL = "https://egypto-mania.com/api/"
//https://egypto-mania.com/api/user/register

///Auth Stuf
let REGISTER = "\(BASE_URL)user/register"
let LOGIN_URL = "\(BASE_URL)user/login"
let USER_LOGOUT = "\(BASE_URL)user/logout"

/// MainTravel Struff
let TRIP_URL = "\(BASE_URL)user/allTrips"
let GALLERY_URL = "\(BASE_URL)user/allGallery"
let TRIP_INFO = "\(BASE_URL)user/information"
let BOOK_TRIP_URL = "\(BASE_URL)user/book"


let PHOTO_URL = "https://egypto-mania.com/"

let img = "https://egypto-mania.com/uploads/1599936688.jpg"

let textPlaceHolderColor = #colorLiteral(red: 0.3647058824, green: 0.4045833051, blue: 0.8775706887, alpha: 0.5)

let NOTIF_USER_CHANGE = Notification.Name("notifuserchange")
