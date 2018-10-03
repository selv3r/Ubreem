//
//  completions.swift
//  aman-user-ios
//
//  Created by Mina Shehata Gad on 5/5/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import SwiftyJSON

//======> Generic JSON Response...................
typealias response = (_ error: String?, _ data: JSON?) -> ()
typealias responseUpload = (_ error: String?, _ data: JSON?, _ uploaded: Double?) -> ()

//=================================================

typealias userCompletion = (_ user: User?, _ success: Bool?, _ error: String?) -> ()
typealias phoneCompletion = (_ code: Int?, _ success: Bool, _ error: String?) -> ()
typealias countryCompletion = (_ country: Country?, _ success: Bool?, _ error: String?) -> ()
typealias orderDataCompletion = (_ orderData: OrderData?, _ success: Bool?, _ error: String?) -> ()
typealias addressDataCompletion = (_ addressData: AddressData?, _ success: Bool?, _ error: String?) -> ()
typealias oneAddressCompletion = (_ address: Address?, _ success: Bool?,_ error: String?) -> ()
typealias addressCompletion = (_ address: [Address]?, _ success: Bool?,_ error: String?) -> ()
typealias orderCompletion = (_ order: Order, _ success: Bool?, _ error: String?) -> ()




