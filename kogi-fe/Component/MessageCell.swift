//
//  MessageCell.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 27/05/24.
//

import SwiftUI

struct MessageCell: View {
    let type: String
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
        HStack {
            if !isMyMessage {
                Spacer()
            }
            
            VStack(alignment: isMyMessage ? .leading : .trailing) {
                if type == "text" {
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
                } else {
                    getConvertedImage(message: message)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .frame(width: 150, height: 150)
                }
                
                Text(formattedTimeStamp)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            if isMyMessage {
                Spacer()
            }
        }
        .padding()
    }
    
    func getConvertedImage(message : String) -> Image {
        if let dataImage = Data(base64Encoded: message) {
            if let uiImage = UIImage(data: dataImage) {
                return Image(uiImage: uiImage)
            }
        }
        return Image(systemName: "camera")
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
//    MessageCell(type: "text", message: "Hello my name is Axel", timeStamp: "2024-05-23T14:52:29", isMyMessage: true)
    MessageCell(type: "image", message: "iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABiSURBVGhD7c+xEYAwEMCwDyuQO/aflDRMIazGtde9n3d+4PrKa1TTqKZRTaOaRjWNahrVNKppVNOoplFNo5pGNY1qGtU0qmlU06imUU2jmkY1jWoa1TSqaVTTqKZRTaOWmQOItwGxNvzd9QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC", timeStamp: "2024-05-23T14:52:29", isMyMessage: true)
}
