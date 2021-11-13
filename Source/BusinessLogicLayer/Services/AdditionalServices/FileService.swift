//
//  FileService.swift
//

import Foundation

protocol FileServiceProtocol {
    func writeFile(file: Data, name: String, completion: VoidBlock)
}

class FileService: FileServiceProtocol {
    
    static func isValidPhotoExtension(extensionName: String) -> Bool {
        switch extensionName {
        case "png","PNG","tiff","TIFF","jpg","JPG","jpeg","JPEG","pdf","PDF": return true
        default: return false
        }
    }
    
    static func isValidFileExtension(extensionName: String) -> Bool {
        switch extensionName {
        case "xls","XLS","xlsx","XLSX","ods","ODS","csv","CSV": return true
        default: return false
        }
    }
    
    func writeFile(file: Data, name: String, completion: VoidBlock) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(name)
        try? file.write(to: path)
        completion?()
    }
}
