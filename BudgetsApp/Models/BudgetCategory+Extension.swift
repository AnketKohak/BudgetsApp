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
    
    var overSpent:Bool{
        remaninigBudgetTotal < 0
    }
    
    
    var trasactionsTotal:Double{
        transactionArray.reduce(0) { result,transaction in
            result + transaction.total
        }
    }
    var remaninigBudgetTotal:Double{
        self.total - trasactionsTotal
    }
    private var transactionArray:[Transaction]{
        guard let transactions = transaction else { return [] }
        let allTransacations = (transactions.allObjects as? [Transaction]) ?? []
        return allTransacations.sorted { t1, t2 in
            t1.dateCreated! > t2.dateCreated!
        }
    }
    static func transactionByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        return request
    }
    
}
