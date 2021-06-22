//
//  LocalFileManager.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 21.06.2021.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        guard let data = image.jpegData(compressionQuality: 0.5),
            let path = getPathForImage(name: name) else {
            print("Error getting data")
            return
        }
        
        do {
            try data.write(to: path)
            print("Success saving!")
        } catch let error {
            print(error.localizedDescription)
        }
        
        //УДАЛИТЬ
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print(directory)
        
        //---------
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            print("Error getting path")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) {
        guard let path = getPathForImage(name: name),
              FileManager.default.fileExists(atPath: path.path) else {
            print("Error getting path")
            return
        }
        do {
            try FileManager.default.removeItem(at: path)
            print("Sucessfully deleted")
        } catch let error {
            print("Error deleting image. \(error)")
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name).jpg") else {
            print("Error getting data")
            return nil
        }
        return path
    }
}
