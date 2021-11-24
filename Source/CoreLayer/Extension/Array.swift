//
//  Array.swift
//
import Foundation

extension Array {
    func isValidIndex(_ index : Int) -> Bool {
        return index < self.count
    }
}
