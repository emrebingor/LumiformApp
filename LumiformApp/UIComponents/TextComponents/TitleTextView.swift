//
//  TitleTextView.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI

struct TitleTextView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(.iColorTitle)
    }
}

