//
//  ProfileCard.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct ProfileCard: View {
    let avatar: String?
    let name: String
    let description: String
    let isProfessor: Bool
    let action: () -> Void
    let isSelectable: Bool
    let isSelected: Bool
    
    init(
        avatar: String?,
        name: String,
        description: String,
        isProfessor: Bool,
        action: @escaping () -> Void,
        isSelectable: Bool,
        isSelected: Bool
    ) {
        self.avatar = avatar
        self.name = name
        self.description = description
        self.isProfessor = isProfessor
        self.action = action
        self.isSelectable = isSelectable
        self.isSelected = isSelected
    }
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .center, spacing: 8) {
                    if let avatar,
                       let avatarURL = URL(string: avatar) {
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
                        .overlay(
                            Circle().stroke(
                                isProfessor ? Color.yellow : Color.red,
                                lineWidth: isProfessor ? 4 : 1
                            )
                        )
                    }
                    Text(name)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                }
                .padding()
                .frame(width: 140, height: 180)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                if isSelectable {
                    ZStack {
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: 24, height: 24)
                            .background(isSelected ? Color.amethystSmoke : Color.clear)
                            .clipShape(Circle())
                        
                        if isSelected {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.white)
                        }
                    }
                    .offset(x: -8, y: 8)
                }
            }
        }
    }
}

#Preview {
    VStack {
        ProfileCard(
            avatar: PreviewData.students.first?.avatar,
            name: PreviewData.students.first?.name ?? "",
            description: PreviewData.students.first?.notes ?? "",
            isProfessor: false,
            action: {},
            isSelectable: true,
            isSelected: true
        )
        ProfileCard(
            avatar: PreviewData.students.first?.avatar,
            name: PreviewData.students.first?.name ?? "",
            description: PreviewData.students.first?.notes ?? "",
            isProfessor: false,
            action: {},
            isSelectable: true,
            isSelected: false
        )
        ProfileCard(
            avatar: PreviewData.professor1.avatar,
            name: PreviewData.professor1.name ?? "",
            description: PreviewData.professor1.subjects.joined(separator: ", "),
            isProfessor: true,
            action: {},
            isSelectable: false,
            isSelected: false
        )
    }
}
