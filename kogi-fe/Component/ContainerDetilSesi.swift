//
//  ContainerDetilSesi.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

//NOTE: PASSING PARAMETER BELUM!!!!!

import SwiftUI

struct ContainerDetilSesi: View {
    
    enum Status {
        case ongoing, done
    }
    
    var session: SessionModel
    var index: Int
    var status: Status {
        switch session.sessionStatus {
        case "ongoing" :
            return Status.ongoing
        case "done" :
            return Status.done
        default :
            return Status.ongoing
        }
    }
    
    var body: some View {
        
            let containerWidth = CGFloat(354)
            let containerHeight = CGFloat(109)
            let imageIconFrame = CGFloat(15)
            let statusContainerWidth = CGFloat(45)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: containerWidth, height: containerHeight)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 4, y: 4)
                
                VStack(alignment: .leading) {
                    
                    HStack(){
                        Text("Sesi \(index)")
                            .font(.system(size: 12, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: imageIconFrame)
                    }
                    
                    ZStack{
                        Rectangle()
                            .frame(width: statusContainerWidth, height: imageIconFrame)
                            .cornerRadius(20)
                            .foregroundColor(statusColor())
                        
                        Text(statusText())
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageIconFrame, height: imageIconFrame)
                            .foregroundColor(Color("primaryColor"))
                        
                        Text("RSGM UNPAD, Kota Bandung")
                            .font(.system(size: 12))
                    }
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageIconFrame, height: imageIconFrame)
                            .foregroundColor(Color("primaryColor"))
                        
                        Text("\(session.dateOfSession.dateToString()) (\(session.dateOfSession.timeToString()))")
                            .font(.system(size: 12))
                    }
                }
                .padding()
            }
            .frame(width: containerWidth, height: containerHeight)
        
    }
    
    func statusColor() -> Color {
        switch status {
        case .ongoing:
            return Color("systemYellow")
        case .done:
            return Color("systemGreen")
        }
    }
    
    func statusText() -> String {
        switch status {
        case .ongoing:
            return "Ongoing"
        case .done:
            return "Done"
        }
    }
}

#Preview {
    ContainerDetilSesi(session: SessionModel(sessionID: "S1", treatmentID: "T1", dateOfSession: "2023-06-20T09:41:00"), index: 1)
}
