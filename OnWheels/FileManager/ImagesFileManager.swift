//
//  ImagesFileManager.swift
//  OnWheels
//
//  Created by Veronika on 30.05.2023.
//

import UIKit

final class ImagesFileManager {
    func saveImageLocally(imageData: Data?, fileName: String) {
        
     // Obtaining the Location of the Documents Directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // Creating a URL to the name of your file
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = imageData {
            do {
                try data.write(to: url) // Writing an Image in the Documents Directory
            } catch {
                print("Unable to Write \(fileName) Image Data to Disk")
            }
        }
    }
    
    func getImageFromName(fileName: String) -> Data? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        if let imageData = try? Data(contentsOf: url) {
//            let image = UIImage(data: imageData)
            return imageData
        } else {
            print("Couldn't get image for \(fileName)")
            return nil
        }
    }
}
