//
//  UIImage.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 22.02.2021.
//  Copyright © 2021 com.chisw. All rights reserved.
//

import UIKit

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

extension UIImageView {
    
    func downloaded(request: EndPointType, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: ((_ image: UIImage) -> Void)?) {
        contentMode = mode
        self.image = UIImage()//Asset.Images.downloadPlaceholder.image
        if let request = try? URLRequest(url: request.url, method: request.httpMethod, headers: request.headers) {
            
            URLSession.shared.dataTask(with: request) { data , response , error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse,
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else {
                    return
                }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                    completion?(image)
                }
            }.resume()
        }
    }
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: ((_ image: UIImage) -> Void)?) {
        contentMode = mode
        self.image = UIImage()//Asset.Images.downloadPlaceholder.image

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                completion?(image)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: ((_ image: UIImage) -> Void)?) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode, completion: completion)
    }
    
    fileprivate var activityIndicator: UIActivityIndicatorView {
        get {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
          activityIndicator.hidesWhenStopped = true
          activityIndicator.center = CGPoint(x:self.frame.width/2,
                                         y: self.frame.height/2)
          activityIndicator.stopAnimating()
          self.addSubview(activityIndicator)
          return activityIndicator
        }
      }
}

//MARK: - Load & Cache image
extension UIImage {
    
    static func download(from url: URL, completion: @escaping ((_ image: UIImage?, _ error: ErrorMessage?) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                DispatchQueue.main.async() {
                    completion(nil, ErrorMessage(message: error.debugDescription))
                }
                return
            }
            DispatchQueue.main.async() {
                completion(image, nil)
            }
        }.resume()
    }
    
    static func saveImage(imageName: String, image: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }

    static func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
}

//MARK: - Resize
extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

//MARK: - JPEGQuality
extension UIImage {
    public enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    public func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
