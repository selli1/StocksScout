//
//  TimeIntervalExtension.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/13/24.
//

import Foundation

extension TimeInterval {
    static var minute: TimeInterval { 60 }
    static var hour: TimeInterval { minute * 60 }
    static var day: TimeInterval { hour * 24 }
    static var week: TimeInterval { day * 7 }
}
