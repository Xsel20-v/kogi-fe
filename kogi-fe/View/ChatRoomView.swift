//
//  ChatRoomView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI

struct ChatRoomView: View {
    
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    @StateObject var treatmentViewModel = TreatmentViewModel()
    
    var body: some View {
        VStack {
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            print(tabSelection)
            
        })
       
    }
}

#Preview {
    ChatRoomView(path: .constant(NavigationPath()), tabSelection: .constant(1))
}
