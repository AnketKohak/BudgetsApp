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
    let onEditBudgetCategory: (BudgetCategory) -> Void
    var body: some View {
        List{
            if !budgetCategoryResults.isEmpty{
                
                ForEach(budgetCategoryResults){ budgetCategory in
                    NavigationLink(value: budgetCategory){
                        HStack{
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10){
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                        
                                Text("\(budgetCategory.overSpent ? "Overspent":"Reamining")\(Text(budgetCategory.remaninigBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth :.infinity,alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundStyle(budgetCategory.overSpent ? .red : .green)
                            }
                        }
                        .onLongPressGesture{
                            onEditBudgetCategory(budgetCategory)
                        }
                        .contentShape(Rectangle())
                                                }
                }.onDelete{ indexSet in
                    indexSet.map{budgetCategoryResults[$0]
                    }.forEach(onDeleteBudgetCategory)
                }
            }
            else {
                Text("No Budget categories Exsit")
            }
            
        }.listStyle(.plain)
        .navigationDestination(for: BudgetCategory.self){budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }
    }
}

