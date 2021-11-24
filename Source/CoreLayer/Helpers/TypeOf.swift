//
//  TypeOf.swift
//

import Foundation

func `isType`<T>(_ instance: Any, of kind: T.Type) -> Bool{
   return instance is T;
}
