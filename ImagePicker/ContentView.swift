//
//  ContentView.swift
//  ImagePicker
//
//  Created by Santiago Mattiauda on on 23/08/24.
//

import SwiftUI
import PhotosUI


struct ImagePicker: View {
    @State var viewModel = ImagePickerViewModel()
    
    let maxPhotosToSelect = 10
    private let columns: [GridItem] =
      Array(repeating: .init(.flexible()),count: 2)
    
    var body: some View {
        NavigationView(content: {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns,spacing: 10) {
                        ForEach(viewModel.images){ item  in
                            Image(uiImage: item.data)
                                .resizable()
                                .aspectRatio(0.67, contentMode: .fit)
                        }
                    }
                }
                PhotosPicker(
                    selection: $viewModel.imagesSelected,
                    maxSelectionCount: maxPhotosToSelect,
                    selectionBehavior: .ordered,
                    matching: .images
                ) {
                    Label("Open gallery", systemImage: "photo")
                }
            }
            .padding()
            .navigationTitle("Image Picker Example")
            .onChange(of: viewModel.imagesSelected) { _, _ in
                viewModel.refresh()
            }
        })
    }
}

#Preview {
    ImagePicker()
}
