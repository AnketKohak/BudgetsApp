//
//  Trancation+CoreDataClass.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 10/10/24.
//

import Foundation
import CoreData

public class Transaction:NSManagedObject{
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}

