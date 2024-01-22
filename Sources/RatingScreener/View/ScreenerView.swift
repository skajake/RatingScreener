//
//  ScreenerView.swift
//  
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

public struct ScreenerView<Style: ButtonStyle>: View {
    
    let buttonStyle: Style
    
    public init(starCount: Int? = nil, buttonStyle: Style) {
        self.buttonStyle = buttonStyle
        self.starCount = starCount
    }
    
    @State var starCount: Int? = nil
    @State var textString: String = "How would you rate us?"
    @State var feedbackText: String = ""
    
    var close: (() -> Void)? = nil
    
    func starTapped(count: Int) {
        guard starCount == nil else {
            return
        }
        var transaction = Transaction(animation: nil)
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            starCount = count
            if count > 4 {
                textString = "Thank you!"
                //Start timer to close this
            } else {
                textString = "How can we improve the app experience?"
            }
        }
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 10) {
                if starCount == nil || starCount ?? 0 > 4 {
                    Image(.thumbUp)
                }
                Text(textString)
                    .modifier(H2())
                    .multilineTextAlignment(.center)
                HStack {
                    Button(action: {
                        starTapped(count: 1)
                    }, label: {
                        Image(starCount ?? 0 > 0 ? .starSelected : .starUnselected)
                    })
                    .disabled(starCount != nil)
                    Button(action: {
                        starTapped(count: 2)
                    }, label: {
                        Image(starCount ?? 0 > 1 ? .starSelected : .starUnselected)
                    })
                    .disabled(starCount != nil)
                    Button(action: {
                        starTapped(count: 3)
                    }, label: {
                        Image(starCount ?? 0 > 2 ? .starSelected : .starUnselected)
                    })
                    .disabled(starCount != nil)
                    Button(action: {
                        starTapped(count: 4)
                    }, label: {
                        Image(starCount ?? 0 > 3 ? .starSelected : .starUnselected)
                    })
                    .disabled(starCount != nil)
                    Button(action: {
                        starTapped(count: 5)
                    }, label: {
                        Image(starCount ?? 0 > 4 ? .starSelected : .starUnselected)
                    })
                    .disabled(starCount != nil)
                }
                .padding(.bottom, 8)
                if starCount == nil {
                    let notNowButton = Button(action: {
                        close?()
                    }, label: {
                        Text("Not Now")
                            .modifier(BodyModifier())
                    })
                    if #available(iOS 15, *) {
                        notNowButton
                            .tint(.white)
                    } else {
                        notNowButton
                            .foregroundColor(.white)
                    }
                }
                if starCount != nil && starCount ?? 0 <= 4 {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $feedbackText)
                            .transparentScrolling()
                            .modifier(TextFieldModifier())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(13)
                        Text("Write a comment (Optional)")
                            .modifier(TextFieldModifier())
                            .foregroundColor(.black.opacity(0.25))
                            .padding(17)
                            .padding(.top, 2)
                            .hidden(!feedbackText.isEmpty)
                            .allowsHitTesting(false)
                    }
                    .frame(maxWidth: 240, maxHeight: 81)
                    .background(Color(.textfield))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    Button {
                        close?()
                    } label: {
                        Text("Submit")
                    }
                    .buttonStyle(buttonStyle)
                    .frame(maxWidth: 240)
                }
            }
            .padding(30)
            .background(Color(.panel))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.background))
        .edgesIgnoringSafeArea(.all)
    }
}

public extension View {
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}

extension View {
    @ViewBuilder public func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}

#Preview {
    VStack {
        ScreenerView(buttonStyle: TestButtonStyle())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
}
