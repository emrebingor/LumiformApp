//
//  CustomUnavailableView.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI

struct CustomUnavailableView: View {
    var title: String
    var description: String
    var imageName: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Text(title)
                .font(.title)
                .bold()
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
            
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}


