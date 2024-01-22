//
//  File.swift
//  
//
//  Created by Jakob Stuber on 1/22/24.
//

import SwiftUI

let pressedScale = 0.96

struct TestButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    @Binding var isEnabled: Bool
    @State var height: CGFloat = 50
    @State var fillWidth: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(ButtonMainLabel())
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
            .frame(height:height)
            .background(
                RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                    .fill(isEnabled ? (configuration.isPressed || isPressed ? Color.gray : Color.white) : Color("MainDisabled"))
                    .shadow(color: Color.gray, radius: 6, x: 0, y: 2))
            .animation(nil, value: configuration.isPressed || isPressed)
            .scaleEffect(configuration.isPressed || isPressed ? pressedScale : 1).animation(.linear(duration: 0.08), value: configuration.isPressed || isPressed ? pressedScale : 1)
    }
}
