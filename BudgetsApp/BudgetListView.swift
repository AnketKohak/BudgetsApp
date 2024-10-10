//
//  BudgetViewList.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 09/10/24.
//

import SwiftUI

struct BudgetListView: View {
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    
    var body: some View {
        List{
            if !budgetCategoryResults.isEmpty{
                
                ForEach(budgetCategoryResults){ budgetCategory in
                    HStack{
                        Text(budgetCategory.title ?? "")
                        Spacer()
                        VStack{
                            Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                        }
                    }
                }
                    
            }
            else {
                Text("No Budget categories Exsit")
            }
            
        }
    }
}

