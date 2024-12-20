//
//  ProfileDetailView.swift
//  beschool
//
//  Created by Igor Squadra on 19/12/24.
//

import SwiftUI

struct ProfileDetailView: View {
    @Environment(\.dismiss) var dismiss
    private let profile: any Profile
    
    init(profile: any Profile) {
        self.profile = profile
    }
    
    var body: some View {
        VStack(spacing: 16) {
            header
                .padding(.horizontal, 24)
            if let avatar = profile.avatar,
               let avatarUrl = URL(string: avatar) {
                AsyncImage(url: avatarUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                                .padding(16)
                        }
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.red, lineWidth: 2))
            }
            Text(profile.email)
                .font(.barlow(size: .calloutSize, weight: .medium))
                .foregroundColor(.gray)
            if let professor = profile as? Professor {
                Text(professor.subjects.joined(separator: ", "))
                    .font(.barlow(size: .bodySize, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            } else if let student = profile as? Student {
                Text(student.notes ?? "")
                    .font(.barlow(size: .bodySize, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding(.vertical)
        .background(Color.whisper)
    }
}

extension ProfileDetailView {
    private var header: some View {
        ZStack {
            HStack {
                IconButton(
                    icon: Image(.back),
                    borderColor: .clear,
                    backgroundColor: .whisper,
                    action: {
                        dismiss()
                    },
                    animateRotation: false
                )
                Spacer()
            }
            Text(profile.name)
                .font(.barlowCondensed(size: .largeTitle1Size, weight: .bold))
        }
    }
}

#Preview {
    ProfileDetailView(profile: PreviewData.students.first!)
//    ProfileDetailView(profile: PreviewData.professor1)
}
