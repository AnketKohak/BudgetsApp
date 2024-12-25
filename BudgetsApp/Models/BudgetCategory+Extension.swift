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
    static var all:NSFetchRequest<BudgetCategory>{
        let request = BudgetCategory.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated",ascending: false)]
        return request
    }
    private var transactionArray:[Transaction]{
        guard let transactions = transaction else { return [] }
        let allTransacations = (transactions.allObjects as? [Transaction]) ?? []
        return allTransacations.sorted { t1, t2 in
            t1.dateCreated! > t2.dateCreated!
        }
    }
    
    static func byId(_ id: NSManagedObjectID) -> BudgetCategory {
        let vc = CoreDataManager.shared.viewContext
        guard let budgetCategory = vc.object(with: id) as? BudgetCategory else {
            fatalError("Id not found")
        }
        return budgetCategory
    }
    static func transactionByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        return request
    }
    
}
