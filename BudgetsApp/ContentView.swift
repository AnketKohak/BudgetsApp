//
//  ContentView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 07/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented:Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var budgetCategoryResult:FetchedResults<BudgetCategory>
    var body: some View {
        NavigationStack{
            VStack {
                List(budgetCategoryResult){ budgetCategory in Text(budgetCategory.title ?? "")
                    
                }
                Text("Hello world ")
            }.sheet(isPresented: $isPresented, content: {
                AddBugetCategoryView()
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
    ContentView()
}
