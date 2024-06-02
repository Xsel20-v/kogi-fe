//
//  OnBoardingPage.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 27/05/24.
//

import SwiftUI

struct OnBoardingPage: View {
    let data: OnboardingData

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(data.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                    .padding(.bottom, 20)
                Text(data.title)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 32))
                    .padding()
                Text(data.description)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .opacity(0.5)
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    OnBoardingPage(data: Constant.OnboardingItems.onboardingItems[0])
}
