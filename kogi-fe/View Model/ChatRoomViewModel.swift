//
//  ChatRoomViewModel.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 03/06/24.
//

import Foundation

class ChatRoomViewModel: ObservableObject {
    
    
    @Published var lastDateShown: String = "-"
    
    func shouldShowDateHeader(_ timestamp: String) -> Bool {
        let dayShown = getFormattedDate(timestamp)
        let shouldShow = dayShown != lastDateShown
        if shouldShow {
            lastDateShown = dayShown
            print(dayShown)
            print(lastDateShown)
        }
        return shouldShow
    }
    
    func getFormattedDate(_ timestamp: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let messageDate = dateFormatter.date(from: timestamp) else {
            return "nil" // Return nil if parsing fails
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        if calendar.isDate(messageDate, inSameDayAs: currentDate) {
            return "Today"
        } else if calendar.isDate(messageDate, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: currentDate)!) {
            return "Yesterday"
        } else {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd MMM YY"
            return displayFormatter.string(from: messageDate)
        }
    }
}
