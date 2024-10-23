//
//  ContentView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 07/10/24.
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
    @State var isPresented:Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults:FetchedResults<BudgetCategory>
    @State private var sheetAction: SheetAction?

    
    var total: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
        }
    }
    private func deleteBudgetCategory(budgetCategory:BudgetCategory){
        viewContext.delete(budgetCategory)
        do{
            try viewContext.save()
        }catch{
            print(error)
            
        }
    }
    private func editBudgetCategory(budgetCategory:BudgetCategory){
        sheetAction = .edit(budgetCategory)
    }
    var body: some View {
        NavigationStack{
            VStack {
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                
                BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory, onEditBudgetCategory: editBudgetCategory)
                
                
            }.sheet(item: $sheetAction, content: { sheetAction in
                // display the sheet
                switch sheetAction {
                    case .add:
                        AddBugetCategoryView()
                    case .edit(_):
                        AddBugetCategoryView()
                }
            })
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add Category"){
                        isPresented = true
                    }
                }
            }.padding()
            
        }
    }
}
    
    
    #Preview {
        ContentView().environment(\.managedObjectContext,CoreDataManager.shared.viewContext)
    }
