//
//  MapPin.swift
//  MapsSwiftUI
//
//  Created by Sahil ChowKekar on 3/6/25.
//

import SwiftUI

struct MapPin: View {
    let name: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.red)
                .shadow(radius: 3)

            Text(name)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.75))
                .cornerRadius(8)
        }
        .padding(8)
    }
}

#Preview {
    MapPin(name: "Current Location")
}
