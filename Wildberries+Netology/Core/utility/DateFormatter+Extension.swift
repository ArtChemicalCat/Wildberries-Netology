//
//  DateFormatter+Extension.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 01.06.2022.
//

import Foundation

extension Date {
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = .current
        return formatter
    }()
    
    func toString() -> String {
        
        return Self.formatter.string(from: self)
    }
}
