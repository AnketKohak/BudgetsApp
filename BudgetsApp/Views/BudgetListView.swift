//
//  BudgetViewList.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 09/10/24.
//

import SwiftUI

struct BudgetListView: View {
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    var body: some View {
        List{
            if !budgetCategoryResults.isEmpty{
                
                ForEach(budgetCategoryResults){ budgetCategory in
                    NavigationLink(value: budgetCategory){
                        HStack{
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack{
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                            }
                        }
                    }
                }.onDelete{ indexSet in
                    indexSet.map{budgetCategoryResults[$0]
                    }.forEach(onDeleteBudgetCategory)
                }
            }
            else {
                Text("No Budget categories Exsit")
            }
            
        }.navigationDestination(for: BudgetCategory.self){budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }
    }
}

