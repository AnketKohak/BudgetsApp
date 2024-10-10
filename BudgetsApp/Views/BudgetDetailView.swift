//
//  BudgetDetailView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 10/10/24.
//

import SwiftUI

struct BudgetDetailView: View {
    
    let budgetCategory: BudgetCategory
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    HStack{
                        Text("Budget:")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }
                
            }
            Spacer()
            
        }
    }
}

