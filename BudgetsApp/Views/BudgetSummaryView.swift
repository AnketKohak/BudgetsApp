//
//  BudgetSummaryView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 13/10/24.
//

import SwiftUI

struct BudgetSummaryView: View {
    
    @ObservedObject var budgetCategory: BudgetCategory
    var body: some View {
        VStack{
            Text("\(budgetCategory.overSpent ? "Overspent":"Reamining")\(Text(budgetCategory.remaninigBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth :.infinity)
                .fontWeight(.bold)
                .foregroundStyle(budgetCategory.overSpent ? .red : .green)
        }
    }
}

