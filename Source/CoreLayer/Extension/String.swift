//
//  String.swift
//
import Foundation
import UIKit

enum DateFormats {
    static let monthYear: String = "MM-yyyy"
    static let backend: String = "yyyy-mm-dd'T'HH:MM:ss.mmmmmm'Z'" // "2021-04-06T11:59:20.125233Z"
    static let backendFull: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" //"2021-06-01T14:57:09.055Z"
}

extension String {
    
    func convertDateString(fromDateFormat: String, toDateFormat: String) -> String? {
        return convert(dateString: self, fromDateFormat: fromDateFormat, toDateFormat: toDateFormat)
    }
    
    func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> String? {
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromDateFormat
        fromDateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let fromDateObject = fromDateFormatter.date(from: dateString) {
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = toDateFormat
            toDateFormatter.calendar = Calendar.current
            toDateFormatter.timeZone = TimeZone.current
            let newDateString = toDateFormatter.string(from: fromDateObject)
            return newDateString
        }

        return nil
    }
        
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func trim() -> String {
      return trimmingCharacters(in: CharacterSet.whitespaces)
    }

    func range(from nsRange: NSRange) -> Range<String.Index>? {
      guard
        let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
        let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
        let from = String.Index(from16, within: self),
        let to = String.Index(to16, within: self)
        else { return nil }
      return from ..< to
    }
    
    func excludeNotNumbers() -> String {
        return self.filter("0123456789.".contains)
    }
    
    func base64Decoded() -> String? {
        var stringtoDecode: String = self.replacingOccurrences(of: "-", with: "+")
        stringtoDecode = stringtoDecode.replacingOccurrences(of: "_", with: "/")
        switch (stringtoDecode.utf8.count % 4) {
            case 2:
                stringtoDecode += "=="
            case 3:
                stringtoDecode += "="
            default:
                break
        }
        guard let data = Data(base64Encoded: stringtoDecode, options: [.ignoreUnknownCharacters]) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func between(_ left: String, _ right: String) -> String? {
        guard let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
        , leftRange.upperBound <= rightRange.lowerBound
            else { return nil }

        let sub = self.substring(from: leftRange.upperBound)
        let closestToLeftRange = sub.range(of: right)!
        return sub.substring(to: closestToLeftRange.lowerBound)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    func trim(_ character: String) -> String {
        let str = self
        if let str = str.components(separatedBy: character).first {
            return str
        }
        
        return self
    }
    
    var bool: Bool? {
            switch self.lowercased() {
            case "true", "t", "yes", "y", "1":
                return true
            case "false", "f", "no", "n", "0":
                return false
            default:
                if let int = Int(self) {
                    return int != 0
                }
                return nil
            }
        }
}

// Style attributed
extension String {
    func strikeThrough() -> NSAttributedString {
           let attributeString =  NSMutableAttributedString(string: self)
           attributeString.addAttribute(
               NSAttributedString.Key.strikethroughStyle,
                  value: NSUnderlineStyle.single.rawValue,
                      range:NSMakeRange(0,attributeString.length))
           return attributeString
       }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var htmlToAttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return nil }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                return nil
            }
        }
        var htmlToString: String {
            return htmlToAttributedString?.string ?? ""
        }
}


extension String {
    /// for this type of strings "10:00"
    func convertToTimeInterval() -> TimeInterval {
        guard self != "" else {
            return 0
        }

        var interval:Double = 0

        let parts = self.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index + 1))
        }

        return interval
    }
}

extension CharacterSet {
    var allCharacters: [Character] {
        var result: [Character] = []
        for plane: UInt8 in 0...16 where self.hasMember(inPlane: plane) {
            for unicode in UInt32(plane) << 16 ..< UInt32(plane + 1) << 16 {
                if let uniChar = UnicodeScalar(unicode), self.contains(uniChar) {
                    result.append(Character(uniChar))
                }
            }
        }
        return result
    }
}
