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
    init(request: NSFetchRequest<Transaction>) {
        _transactions = FetchRequest(fetchRequest: request)
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
                    
                }
                
            }
        }
    }
}

