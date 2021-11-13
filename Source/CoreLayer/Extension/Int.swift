//
//  Int.swift
//
import Foundation

extension Int {
    var boolValue: Bool { return self != 0 }
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
