//
//  BudgetsAppApp.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 07/10/24.
//

import SwiftUI

@main
struct BudgetsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext,CoreDataManager.shared.viewContext)
        }
    }
}
