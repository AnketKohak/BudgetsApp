//
//  BudgetDetailView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 10/10/24.
//

import SwiftUI
import CoreData
struct BudgetDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var title:String = ""
    @State private var total:String = ""
    var isFormVaild:Bool{
        guard let totalAsDouble = Double(total) else{ return false }
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
        
    }
    func saveTransaction(){
        do{
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total)!
            budgetCategory.addToTransaction(transaction)
            try viewContext.save()
        }catch{
            print(error)
        }
        
    }
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
                    }.fontWeight(.bold)
                }
                
            }
            Form{
                Section{
                    TextField("Title",text: $title)
                    TextField("Total",text: $total)
                } header: {
                        Text("Add Trasnaction")
                }
                HStack{
                    Spacer()
                    Button("Save Trasnaction"){
                        
                    }.disabled(!isFormVaild)
                    Spacer()
                }
            }
            
            Spacer()
            
        }
    }
}

