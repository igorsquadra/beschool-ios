//
//  ProfileCard.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct ProfileCard: View {
    let avatarURL: URL?
    let name: String
    let description: String

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            AsyncImage(url: avatarURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle()
                    .fill(.white)
                    .overlay {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                    }
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.red, lineWidth: 2))

            Text(name)
                .font(.subheadline)
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            // Description
            Text(description)
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(width: 140)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
