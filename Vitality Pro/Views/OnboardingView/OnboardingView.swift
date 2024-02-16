//
//  OnboardingView.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 15.02.24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.orange.gradient)
                .ignoresSafeArea(.all)

            VStack(alignment: .leading) {
                Text("Vitality Pro")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.white)

                Spacer()

                VStack(alignment: .leading, spacing: 20) {
                    Text("More and more people around the world choose fast food because of its convenience and taste. However, fast food often lacks essential nutrients, especially vitamins.")

                    Text("Preventing vitamin deficiency is straightforward. Incorporating a variety of vegetables and fruits into your regular diet can make a significant difference. This healthy practice, which doesn't demand much time, ensures your body receives the essential vitamins needed for proper functioning.")

                    Text("**Vitality Pro** makes it easy to track your daily vitamin intake. By capturing images of the fruits and vegetables you eat, the app automatically identifies corresponding vitamin levels and stores them through Apple's **Health** app. This not only provides valuable insights into your food intake but also helps you maintaining a healthy lifestyle.")
                }
                .foregroundStyle(Color.white)

                Spacer()
                Spacer()

                HStack {
                    Spacer()

                    Button(action: {
                        dismiss()
                    }) {
                        Text("Get Started & Connect Health")
                            .fontWeight(.semibold)
                            .font(.headline)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundStyle(Color.white)
                            }
                    }

                    Spacer()
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .leading
            )
            .padding(25)
        }
    }
}

#Preview {
    OnboardingView()
        .environment(HealthKitViewModel())
}
