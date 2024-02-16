//
//  UnavailableView.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 15.02.24.
//

import SwiftUI

struct UnavailableView: View {
    var body: some View {
        VStack {
            ContentUnavailableView(label: {
                Label(
                    title: { Text("Unable to load Health data.") },
                    icon: {
                        HStack(spacing: 10) {
                            Image(systemName: "carrot.fill")
                                .foregroundStyle(Color.orange.gradient)
                            
                            Text("+")
                                .font(.title)
                            
                            Image(systemName: "heart.fill")
                                .foregroundStyle(Color.pink.gradient)
                        }
                    }
                )
            }, description: {
                Text("Please allow Vitality Pro to access your health data to use this app.")
            })
        }
        
        ProgressView()
            .controlSize(.large)
    }
}

#Preview {
    UnavailableView()
}
