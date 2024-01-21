//
//  ScreenerView.swift
//  
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

public struct ScreenerView: View {
    
    public init() {}
    
    var close: (() -> Void)? = nil
    
    public var body: some View {
        Button(action: {
            close?()
        }, label: {
            ZStack {
                Text("Test")
                    .background(Color.white)
            }
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green.opacity(0.3))
        })
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    VStack {
        ScreenerView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
}
