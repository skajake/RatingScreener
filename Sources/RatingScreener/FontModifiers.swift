//
//  File.swift
//  
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

struct H2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
    }
}

struct BodyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .regular))
            .foregroundColor(.white)
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.white)
    }
}

struct ButtonMainLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.purple)
            .modifier(H2())
            .padding(.vertical, 12.5)
            .padding(.horizontal, 16.0)
    }
}
