//
//  Movie.swift
//  MovieTicketBooking
//
//  Created by ljh on 9/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String;
    let date: String;
    let voteAverage: Double;
    let overview: String;
    let posterPath: String;
}
