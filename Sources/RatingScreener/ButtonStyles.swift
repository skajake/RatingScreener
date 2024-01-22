//
//  File.swift
//  
//
//  Created by Jakob Stuber on 1/22/24.
//

import SwiftUI

let pressedScale = 0.96

public struct TestButtonStyle: ButtonStyle {
    @State var isPressed = false
    @State var height: CGFloat = 50
    @State var fillWidth: Bool = true
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(ButtonMainLabel())
            .padding(.horizontal, 10)
            .frame(height:height)
            .background(
                RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                    .fill(configuration.isPressed || isPressed ? Color.gray : Color.white)
                    .shadow(color: Color.gray, radius: 6, x: 0, y: 2))
            .animation(nil, value: configuration.isPressed || isPressed)
            .scaleEffect(configuration.isPressed || isPressed ? pressedScale : 1).animation(.linear(duration: 0.08), value: configuration.isPressed || isPressed ? pressedScale : 1)
    }
}
