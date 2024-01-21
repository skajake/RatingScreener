//
//  RatingScreenerHost.swift
//
//
//  Created by Jakob Stuber on 1/21/24.
//

import SwiftUI

public class RatingScreenerHost : UIHostingController<ScreenerView> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
    }
}
