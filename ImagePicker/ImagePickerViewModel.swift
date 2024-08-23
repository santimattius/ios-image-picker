//
//  ImagePickerViewModel.swift
//  ImagePicker
//
//  Created by Santiago Mattiauda on 23/08/24.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
class ImagePickerViewModel {
    var images = [Picture]()
    var imagesSelected = [PhotosPickerItem]()
    
    @MainActor
    func refresh() {
        images.removeAll()
        
        if !imagesSelected.isEmpty {
            for eachItem in imagesSelected {
                Task {
                    if let imageData = try? await eachItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: imageData) {
                            images.append(Picture(data: image))
                        }
                    }
                }
            }
        }
     
        imagesSelected.removeAll()
    }
}

struct Picture : Identifiable {
    let id = UUID()
    let data: UIImage
}
