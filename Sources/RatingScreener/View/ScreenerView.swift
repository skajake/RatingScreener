//
//  ScreenerView.swift
//  
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

public struct ScreenerView<Style: ButtonStyle>: View {
    
    let buttonStyle: Style
    let starColor: Color
    
    public init(starCount: Int? = nil, buttonStyle: Style, starColor: Color) {
        self.buttonStyle = buttonStyle
        self.starColor = starColor
        self.starCount = starCount
    }
    
    @State var starCount: Int? = nil
    @State var textString: String = "How would you rate us?"
    @State var feedbackText: String = ""
    
    var cancel: (() -> Void)? = nil
    var fiveStar: (() -> Void)? = nil
    var feedback: ((String) -> Void)? = nil
    
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
                fiveStar?()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    cancel?()
                }
            } else {
                textString = "How can we improve the app experience?"
            }
        }
    }
    
    public var body: some View {
        ZStack {
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
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
                                .foregroundColor(starColor)
                        })
                        .disabled(starCount != nil)
                        Button(action: {
                            starTapped(count: 2)
                        }, label: {
                            Image(starCount ?? 0 > 1 ? .starSelected : .starUnselected)
                                .foregroundColor(starColor)
                        })
                        .disabled(starCount != nil)
                        Button(action: {
                            starTapped(count: 3)
                        }, label: {
                            Image(starCount ?? 0 > 2 ? .starSelected : .starUnselected)
                                .foregroundColor(starColor)
                        })
                        .disabled(starCount != nil)
                        Button(action: {
                            starTapped(count: 4)
                        }, label: {
                            Image(starCount ?? 0 > 3 ? .starSelected : .starUnselected)
                                .foregroundColor(starColor)
                        })
                        .disabled(starCount != nil)
                        Button(action: {
                            starTapped(count: 5)
                        }, label: {
                            Image(starCount ?? 0 > 4 ? .starSelected : .starUnselected)
                                .foregroundColor(starColor)
                        })
                        .disabled(starCount != nil)
                    }
                    .padding(.bottom, 8)
                    if starCount == nil {
                        let notNowButton = Button(action: {
                            cancel?()
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
                        .frame(maxWidth: 240)
                        .frame(height: 81)
                        .background(Color(.textfield))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        Button {
                            feedback?(feedbackText)
                        } label: {
                            Text("Submit")
                                .padding(.vertical, 14)
                                .frame(maxWidth: 240)
                        }
                        .buttonStyle(buttonStyle)
                        .padding(.top, 8)
                    }
                }
                .padding(30)
            }
            .frame(maxWidth: 300)
            .fixedSize(horizontal: true, vertical: true)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.background))
        .edgesIgnoringSafeArea(.all)
    }
}

public struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    public func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
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
        ScreenerView(buttonStyle: TestButtonStyle(), starColor: .blue)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
}
