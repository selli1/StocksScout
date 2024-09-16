//
//  DateExtension.swift
//  StocksScout
//
//  Created by Steven Elliott on 9/16/24.
//

import Foundation

extension Date {
    public func toMilliSeconds()-> TimeInterval {
        return TimeInterval(self.timeIntervalSince1970)
    }
}
