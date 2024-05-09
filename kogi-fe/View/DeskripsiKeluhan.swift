//
//  DeskripsiKeluhan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 09/05/24.
//

import SwiftUI

struct DeskripsiKeluhan: View {
    
    var category: String
    
    var body: some View {
        VStack {
            HeaderView(category: category)
            BodyView(category: category)
            Spacer()
        }
        .ignoresSafeArea()
        
    }
}

struct HeaderView : View {
    
    var category: String
    
    var blueRectangleWidth: CGFloat = 393
    var blueRectangleHeight: CGFloat = 98
    var body: some View{
        ZStack {
            Rectangle()
                .fill(Constant.Colors.primaryColor)
                .frame(width: blueRectangleWidth, height: blueRectangleHeight)
            Text(category)
                .foregroundColor(Constant.Colors.baseColor)
                .padding(.top, 60)
        }
    }
}

struct BodyView : View {
    var category: String
    
    var body: some View {
        VStack {
            switch (category) {
            case Constant.Categories.karangGigi :
                AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
            case Constant.Categories.sakitGigi :
                AutoScroller(imageNames: ["gigiBerlubang1", "gigiBerlubang2", "gigiBerlubang3"])
            case Constant.Categories.cabutGigi :
                AutoScroller(imageNames: ["cabutGigi1", "cabutGigi2"])
            case Constant.Categories.gigiTiruan :
                AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
            case Constant.Categories.kawatLepasan :
                AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
            case Constant.Categories.gusiBengkak :
                AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
            case Constant.Categories.sariawan :
                AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
            default :
                AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
            }
                
            
        }
        
        
    }
}

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
                .offset(y: 80) // Step 15: Adjust Dots Position
            }
        }
        .offset(y : -30)
    }
}

#Preview {
    DeskripsiKeluhan(category: "Sakit Gigi")
}
