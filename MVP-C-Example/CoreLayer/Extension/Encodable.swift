//
//  JSONEncoder.swift
//  PharmacyPortal
//
//  Created by user on 23.11.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
