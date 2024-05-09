//
//  ToolbarView.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 15.02.24.
//

import SwiftUI

struct ToolbarView: ToolbarContent {
    @Environment(PropertyModel.self) var properties

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Camera", systemImage: "camera.fill", action: {
                self.properties.showCamera.toggle()
            })
        }

        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Settings", systemImage: "carrot.fill", action: {
                self.properties.showSettings.toggle()
            })

            Button("Information", systemImage: "person.fill", action: {
                self.properties.showInfo.toggle()
            })
        }
    }
}
