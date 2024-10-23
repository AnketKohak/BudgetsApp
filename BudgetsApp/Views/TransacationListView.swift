//
//  TransacationListView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 13/10/24.
//

import SwiftUI
import CoreData
struct TransacationListView: View {
    @FetchRequest var transactions: FetchedResults<Transaction>
    let onDeleteTransaction: (Transaction) -> Void
    init(request: NSFetchRequest<Transaction>,onDeleteTransaction: @escaping (Transaction) -> Void) {
        _transactions = FetchRequest(fetchRequest: request)
        self.onDeleteTransaction = onDeleteTransaction
    }
    
    var body: some View {
        if transactions.isEmpty{
            Text("No Transaction.")
        }
        else{
            List{
                ForEach(transactions){ transaction in
                    HStack{
                        Text(transaction.title ?? "")
                        Spacer()
                        Text(transaction.total as NSNumber,formatter: NumberFormatter.currency)
                    }
                    
                }.onDelete{ offsets in
                    offsets.forEach{ transaction in
                        offsets.map { transactions[$0] }.forEach(onDeleteTransaction)
                    }
                    
                }
                
            }
        }
    }
}

