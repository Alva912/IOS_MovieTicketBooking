//
//  BookingListItem.swift
//  MovieTicketBooking
//
//  Created by ljh on 14/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import Foundation

struct BookingListItem: Codable {
    let movieObj: MovieResult
    var number: Int
    let unitPrice: Int
}
