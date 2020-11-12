//
//  DateHelper.swift
//  Task
//
//  Created by Michael Nguyen on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}
