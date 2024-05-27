//
//  MessageCell.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 27/05/24.
//

import SwiftUI

struct MessageCell: View {
    let message: String
    let timeStamp: String
    let isMyMessage: Bool
    
    var formattedTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: timeStamp) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            return timeFormatter.string(from: date)
        }
        return "Invalid time"
    }

    var body: some View {
        VStack(alignment: isMyMessage ? .trailing : .leading) {
            Text(message)
                .padding(10)
                .foregroundColor(.black)
                .background(isMyMessage ? Constant.Colors.myMessage : Constant.Colors.notMyMessage)
                .cornerRadius(10)
                .shadow(radius: 2)
                .overlay(alignment: isMyMessage ? .bottomLeading : .bottomTrailing) {
                    Triangle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(isMyMessage ? Constant.Colors.myMessage : Constant.Colors.notMyMessage)
                        .offset(x: isMyMessage ? -7 : 7, y: 1.5)
                }
            
            Text(formattedTimeStamp)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
            
        
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Start from the top-center
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        // Add line to the bottom-left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        // Add line to the bottom-right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Close the path
        path.closeSubpath()
        return path
    }
}

#Preview {
    MessageCell(message: "Hello my name is Jonathan Axel Benaya, i live in Bandung. I Like to code and now I am currently finishing my thesis", timeStamp: "2024-05-23T14:52:29", isMyMessage: false)
}
