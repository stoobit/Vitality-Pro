//
//  UnavailableView.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 15.02.24.
//

import SwiftUI

struct UnavailableView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)

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
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: { dismiss() })
                }
            }
        }
    }
}

#Preview {
    UnavailableView()
}
