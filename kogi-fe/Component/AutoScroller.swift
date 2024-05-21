//
//  AutoScroller.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 10/05/24.
//

import SwiftUI

struct AutoScroller: View {
    var imageNames: [String]
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    // Step 3: Manage Selected Image Index
    @State private var selectedImageIndex: Int = 0
    
    var imageWidth : CGFloat = 342
    var imageHeight : CGFloat = 220
    
    var body: some View {
        ZStack {
            
            // Step 5: Create TabView for Carousel
            TabView(selection: $selectedImageIndex) {
                // Step 6: Iterate Through Images
                ForEach(0..<imageNames.count, id: \.self) { index in
                    ZStack(alignment: .topLeading) {
                        // Step 7: Display Image
                        Image("\(imageNames[index])")
                            .resizable()
                            .tag(index)
                            .frame(width: imageWidth, height: imageHeight)
                            .cornerRadius(10)
                    }
                }
            }
            .frame(height: 300) // Step 10: Set Carousel Height
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Step 11: Customize TabView Style
            .ignoresSafeArea()
            .clipped()
            
            // Step 12: Navigation Dots
            HStack {
                ForEach(0..<imageNames.count, id: \.self) { index in
                    // Step 13: Create Navigation Dots
                    Capsule()
                        .fill(Color.white.opacity(selectedImageIndex == index ? 1 : 0.33))
                        .frame(width: 10, height: 10)
                        .onTapGesture {
                            // Step 14: Handle Navigation Dot Taps
                            selectedImageIndex = index
                        }
                }
                .offset(y: 90) // Step 15: Adjust Dots Position
            }
        }
        .frame(width: imageWidth, height: imageHeight)
    }
}


#Preview {
    AutoScroller(imageNames: ["gigiTiruan2", "gigiBerlubang1"])
}
