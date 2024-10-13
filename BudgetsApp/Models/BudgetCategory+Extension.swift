//
//  BudgetCategory+Extension.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 07/10/24.
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory:NSManagedObject{
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    static func transactionByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        return request
    }
    
}
