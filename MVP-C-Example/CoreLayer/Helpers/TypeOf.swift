//
//  TypeOf.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 10.12.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation

func `isType`<T>(_ instance: Any, of kind: T.Type) -> Bool{
   return instance is T;
}
