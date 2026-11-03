//
//  ScreenerView.swift
//  
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI
import Combine

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
    @State private var keyboardHeight: CGFloat = 0
    
    var close: (() -> Void)? = nil
    var cancel: (() -> Void)? = nil
    var fiveStar: (() -> Void)? = nil
    var feedback: ((Int, String) -> Void)? = nil
    
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
                    close?()
                }
            } else {
                textString = "How can we improve the app experience?"
            }
        }
    }
    
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    /// Liquid Glass on iOS 26+ pairs with a larger corner radius; 20pt everywhere else.
    private var panelCornerRadius: CGFloat {
        if #available(iOS 26.0, *) {
            return 28
        }
        return 20
    }

    /// The panel behind the content. The dark blur blended into dark screens behind the
    /// dimmed backdrop, leaving the panel's edges hard to make out; Liquid Glass on iOS 26+
    /// gives it a visible edge. Solid with Reduce Transparency on.
    @ViewBuilder
    private var panelBackground: some View {
        if reduceTransparency {
            Color.black
        } else if #available(iOS 26.0, *) {
            VisualEffectView(effect: UIGlassEffect(), cornerRadius: panelCornerRadius)
        } else {
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        }
    }

    public var body: some View {
        ZStack {
            Color(.background)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                panelBackground
                VStack(spacing: 10) {
                    if starCount == nil || starCount ?? 0 > 4 {
                        Image(.thumbUp)
                    }
                    Text(textString)
                        .modifier(H2())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                        .padding(.top, starCount != nil && starCount ?? 0 < 5 ? 10 : 0)
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
                    .padding(.horizontal, 10)
                    if starCount == nil {
                        let notNowButton = Button(action: {
                            cancel?()
                        }, label: {
                            VStack {
                                Text("Not Now")
                                    .modifier(BodyModifier())
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 10)
                                    .padding(.bottom, 28)
                            }
                            .contentShape(Rectangle())
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
                                .keyboardType(.default)
                                .submitButton()
                                .onChange(of: feedbackText) { _ in
                                    if !feedbackText.filter({ $0.isNewline }).isEmpty {
                                        feedback?(starCount ?? 0, feedbackText)
                                        close?()
                                    }
                                }
                                .padding(10)
                            Text("Write a comment (Optional)")
                                .modifier(TextFieldModifier())
                                .foregroundColor(.black.opacity(0.25))
                                .padding(15)
                                .padding(.top, 0)
                                .hidden(!feedbackText.isEmpty)
                                .allowsHitTesting(false)
                        }
                        .frame(maxWidth: 300)
                        .frame(height: 80)
                        .background(Color(.textfield))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding(.top, 10)
                        Button {
                            feedback?(starCount ?? 0, feedbackText)
                            close?()
                        } label: {
                            Text("Submit")
                                .padding(.vertical, 14)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(buttonStyle)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 28)
                .padding(.bottom, starCount == nil ? 0 : 28)
            }
            .frame(maxWidth: 300)
            .fixedSize(horizontal: false, vertical: true)
            .clipShape(RoundedRectangle(cornerRadius: panelCornerRadius, style: .continuous))
            .padding(.bottom, keyboardHeight)
            
        }
        .contentShape(Rectangle())
        .edgesIgnoringSafeArea(.all)
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 / 2.0 }
    }
}

public struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    /// Glass draws its edge from the view's own corners, so it needs them set here rather
    /// than only clipped by SwiftUI.
    var cornerRadius: CGFloat = 0
    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    public func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
        uiView.layer.cornerRadius = cornerRadius
        uiView.layer.cornerCurve = .continuous
        uiView.clipsToBounds = cornerRadius > 0
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

public extension View {
    func submitButton() -> some View {
        if #available(iOS 16.0, *) {
            return submitLabel(.send)
        }
        return self
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
