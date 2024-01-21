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
                VStack(spacing: 0) {
                    Text("How would you rate us?")
                        .foregroundColor(Color.white)
                        .padding(20)
                }
                .background(Color(.panel))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.background))
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
