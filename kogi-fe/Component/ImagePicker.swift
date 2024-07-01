//
//  ImagePicker.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 15/05/24.
//

import PhotosUI
import SwiftUI

struct ImagePicker: View {
    
    @State var selectedItems: [PhotosPickerItem] = []
    @Binding var imagesData: [Data]
    
    var placeholder: String
    
    var body: some View {
        VStack {
            
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 5,
                matching: .images
            )
            {
                ZStack{
                    Image("uploadImageFrame")
                    VStack{
                        Image(systemName: "camera")
                        Text(placeholder)
                            .font(.system(size: 14))
                            .padding(.top, 5)
                    }
                }
            }
            .onChange(of: selectedItems) { newItems in
                Task {
                    await loadImagesData(from: newItems)
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(imagesData, id: \.self) { data in
                        if let uiimage = UIImage(data: data) {
                            Image(uiImage: uiimage)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                                .padding(.leading, 10)
                                .padding(5)
                        } else {
                            Text("no image selected")
                        }
                    }
                }
            }
        }
    }
    
    func loadImagesData(from items: [PhotosPickerItem]) async {
        var newImagesData: [Data] = []
        for item in items {
            do {
                if let data = try await item.loadTransferable(type: Data.self) {
                    newImagesData.append(data)
                    print(data.base64EncodedString())
                } else {
                    print("Data is nil for item \(item)")
                }
            } catch {
                print("Failed to load image data for item \(item): \(error.localizedDescription)")
            }
        }
        self.imagesData = newImagesData
    }
}

#Preview {
    ImagePicker(imagesData: .constant([]), placeholder: "Ambil Foto Gigi Anda")
}
