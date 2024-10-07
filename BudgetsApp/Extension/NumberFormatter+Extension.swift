//
//  NumberFormatter+Extension.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 07/10/24.
//

import Foundation

extension NumberFormatter{
    
    static var currency : NumberFormatter{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
