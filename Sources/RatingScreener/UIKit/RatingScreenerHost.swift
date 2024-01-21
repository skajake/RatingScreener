//
//  RatingScreenerHost.swift
//
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

public class RatingScreenerHost : UIHostingController<ScreenerView> {
    
    public override init(rootView: ScreenerView) {
        super.init(rootView: rootView)
        view.backgroundColor = .clear
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
