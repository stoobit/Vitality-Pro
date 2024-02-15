//
//  UnavailableView.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 15.02.24.
//

import SwiftUI

struct UnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "Unable to load Health Data.",
            systemImage: "heart.slash.fill"
        )
    }
}

#Preview {
    UnavailableView()
}
