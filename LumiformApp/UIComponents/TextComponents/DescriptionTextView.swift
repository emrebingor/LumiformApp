//
//  DescriptionTextView.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI

struct DescriptionTextView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .light))
            .foregroundStyle(.iColorDescription)
    }
}
