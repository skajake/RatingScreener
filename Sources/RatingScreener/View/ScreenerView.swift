//
//  ScreenerView.swift
//  
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

public struct ScreenerView: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
            Text("Test")
                .background(Color.white)
        }
    }
}

#Preview {
    VStack {
        ScreenerView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.red)
}
