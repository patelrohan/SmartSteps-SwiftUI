//
//  Date+Ext.swift
//  SmartSteps-SwiftUI
//
//  Created by Rohan Patel on 11/10/26.
//

import Foundation

extension Date{

    var weekdayInt: Int{
        Calendar.current.component(.weekday, from: self)
    }
}
