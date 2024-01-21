//
//  ScreenerView.swift
//  
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

public struct ScreenerView: View {
    
    public init() {}
    
    @State var starCount: Int? = nil
    
    var close: (() -> Void)? = nil
    
    func starTapped(count: Int) {
        starCount = count
    }
    
    public var body: some View {
        Button(action: {
            close?()
        }, label: {
            ZStack {
                VStack(spacing: 10) {
                    Image(.thumbUp)
                    Text("How would you rate us?")
                        .modifier(H2())
                    HStack {
                        Button(action: {
                            starTapped(count: 1)
                        }, label: {
                            Image(starCount ?? 0 > 0 ? .starSelected : .starUnselected)
                        })
                        Button(action: {
                            starTapped(count: 2)
                        }, label: {
                            Image(starCount ?? 0 > 1 ? .starSelected : .starUnselected)
                        })
                        Button(action: {
                            starTapped(count: 3)
                        }, label: {
                            Image(starCount ?? 0 > 2 ? .starSelected : .starUnselected)
                        })
                        Button(action: {
                            starTapped(count: 4)
                        }, label: {
                            Image(starCount ?? 0 > 3 ? .starSelected : .starUnselected)
                        })
                        Button(action: {
                            starTapped(count: 5)
                        }, label: {
                            Image(starCount ?? 0 > 4 ? .starSelected : .starUnselected)
                        })
                    }
                    .padding(.bottom, 8)
                    Button(action: {
                        
                    }, label: {
                        Text("Not Now")
                            .modifier(BodyModifier())
                    })
                    .tint(.white)
                }
                .padding(30)
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
