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
