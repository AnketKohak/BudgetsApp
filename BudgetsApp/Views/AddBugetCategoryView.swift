//
//  AddBugetCategoryView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 07/10/24.
//

import SwiftUI

struct AddBugetCategoryView: View {
    @State private var title:String = ""
    @State private var total:Double = 0
    @State private var messages :[String] = []
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var isFormVaild : Bool{
        messages.removeAll()
        if title.isEmpty{
            messages.append("Title is reqired")
        }
        if total <= 0{
            messages.append("Total should greather than 1")
        }
        
        return messages.count == 0
    }
    
    private func save(){
        let budgetCategory = BudgetCategory(context: viewContext)
        budgetCategory.title = title
        budgetCategory.total = total
        
        do{
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                Slider(value :$total,in:0...10000,step:50){
                    Text("Total")
                } minimumValueLabel: {
                    Text(0 as NSNumber,formatter: NumberFormatter.currency)
                } maximumValueLabel: {
                    Text(10000 as NSNumber,formatter: NumberFormatter.currency)
                }
                Text(total as NSNumber,formatter: NumberFormatter.currency)
                    .frame(maxWidth:.infinity, alignment: .center)
                ForEach(messages, id:\.self){ message in
                    Text(message)
                    
                }
                
            }.toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        if isFormVaild{
                            save()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddBugetCategoryView()
}
