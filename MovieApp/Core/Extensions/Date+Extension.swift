//
//  Date+Extension.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 15.08.23.
//

import Foundation

extension Date {
    func formattedDate(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

let todayDate = Date()
let formattedTodayDate = todayDate.formattedDate("yyyy-MM-dd")
