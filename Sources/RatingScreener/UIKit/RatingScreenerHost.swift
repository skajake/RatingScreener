//
//  RatingScreenerHost.swift
//
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

public class RatingScreenerHost<Style: ButtonStyle> : UIHostingController<ScreenerView<Style>> {
    
    public override init(rootView: ScreenerView<Style>) {
        super.init(rootView: rootView)
        view.backgroundColor = .clear
        view.isOpaque = false
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
        rootView.close = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
}
