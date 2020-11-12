//
//  Task+Convenience.swift
//  Task
//
//  Created by Michael Nguyen on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
extension Task {
    convenience init(name: String, notes: String?, due: Date?, isComplete: Bool = false) {
        self.init(context: CoreDataStack.context)
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = isComplete
    }
}
