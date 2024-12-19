//
//  ClassroomCard.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct ClassroomCard: View {
  let classroomName: String
  let professorName: String
  let students: [Student]
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      VStack(alignment: .leading, spacing: 4) {
        Text(classroomName)
          .font(.barlowCondensed(size: .title2Size, weight: .bold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .foregroundColor(.black.opacity(0.8))
        
        VStack(alignment: .leading, spacing: 0) {
          Text("Prof:")
            .font(.barlowCondensed(size: .footnoteSize, weight: .bold))
            .foregroundColor(.black.opacity(0.8))
          Text(professorName)
            .font(.barlow(size: .footnoteSize, weight: .medium))
            .foregroundColor(.black.opacity(0.8))
        }
        
        HStack(spacing: -8) {
          ForEach(0..<min(students.count, 3), id: \.self) { index in
            if let avatar = students[index].avatar,
               let avatarUrl = URL(string: avatar) {
              AsyncImage(url: avatarUrl) { image in
                image
                  .resizable()
                  .scaledToFill()
              } placeholder: {
                Color.gray.opacity(0.3)
              }
              .frame(width: 24, height: 24)
              .clipShape(Circle())
              .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
          }
          if students.count > 3 {
            Text("+\(students.count - 3)")
              .font(.barlow(size: .footnoteSize, weight: .bold))
              .foregroundColor(.black)
              .frame(width: 24, height: 24)
              .background(Color.white.opacity(0.8))
              .clipShape(Circle())
              .overlay(Circle().stroke(Color.black, lineWidth: 1))
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      .frame(height: 100)
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
      .shadow(radius: 6)
    }
  }
}

#Preview {
  ScrollView {
    LazyVGrid(
      //        columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2),
      columns: [GridItem(.adaptive(minimum: 164), spacing: 16)],
      spacing: 20
    ) {
      ForEach(PreviewData.classrooms, id: \.id) { classroom in
        ClassroomCard(
          classroomName: classroom.roomName,
          professorName: classroom.professor?.name ?? "-",
          students: classroom.students,
          action: {}
        )
        .transition(
          .scale(scale: 0.0, anchor: .center)
          .combined(with: .opacity)
        )
        .animation(.easeOut(duration: 0.5), value: PreviewData.classrooms)
      }
    }
    .padding(.horizontal, 24)
  }
  .background(.whisper)
}
