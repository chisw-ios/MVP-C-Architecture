//
//  Profile.swift
//

import Foundation

class UserProfile: Codable {
    var id: Int?
    var email: String?
    var phone: String?
    var receiveNews: Bool = false
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var additionalInfo: AdditionalInfo?
    
    var fullName: String {
        get {
            guard let name = self.firstName, let surname = self.lastName else { return "" }
            return name +  " "  + surname
        }
    }
}

class AdditionalInfo: Codable {
    var id: Int?
    var gender: GenderModel?
}

enum GenderModel: String, Codable {
    case female = "FEMALE",
        male = "MALE"
}

extension UserProfile {
    
    var jsonForRequest: [String : Any] {
        
        var profileJson: [String : Any] = [:]
        if let firstName = firstName { profileJson["firstName"] = firstName }
        if let lastName = lastName { profileJson["lastName"] = lastName }
        if let email = email { profileJson["email"] = email }
        if let middleName = middleName { profileJson["middleName"] = middleName }
        if let gender = additionalInfo?.gender { profileJson["gender"] = gender.rawValue }
        return profileJson
    }
}
