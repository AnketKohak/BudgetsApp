//
//  ContentView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 10/10/24.
//

import SwiftUI
import CoreData


enum SheetAction: Identifiable {
    
    case add
    case edit(BudgetCategory)
    
    var id: Int {
        switch self {
            case .add:
                return 1
            case .edit(_):
                return 2
        }
    }
    
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @FetchRequest(fetchRequest: BudgetCategory.all) var budgetCategoryResults
    @State private var sheetAction: SheetAction?
    
    var total: Double { 
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
        
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func editBudgetCategory(budgetCategory: BudgetCategory) {
        sheetAction = .edit(budgetCategory)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Total:")
                    Text(total as NSNumber, formatter: NumberFormatter.currency)
                        .fontWeight(.bold)
                }
                
                BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory, onEditBudgetCategory: editBudgetCategory)
            }
            .sheet(item: $sheetAction, content: { sheetAction in
                // display the sheet
                switch sheetAction {
                    case .add:
                        AddBudgetCategoryView()
                    case .edit(let budgetCategory):
                        AddBudgetCategoryView(budgetCategory: budgetCategory)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        sheetAction = .add
                    }
                }
            }.padding()
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
