//
//  AddClassroomView.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct AddClassroomView: View {
    @EnvironmentObject var appManager: AppManager
    @Binding var isPresented: Bool
    @State private var roomName: String = ""
        
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("ADD NEW CLASSROOM")
                    .font(.barlowCondensed(size: .largeTitle2Size, weight: .bold))
                Spacer()
                Button {
                    withAnimation {
                        isPresented = false
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.amethystSmoke)
                        .frame(width: 34, height: 34)
                        .overlay {
                            Image(.close)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .frame(width: 14, height: 14)
                        }
                        
                }
            }
            .padding(.horizontal, 24)
            VStack(alignment: .leading, spacing: 10) {
                Text("ROOM NAME")
                    .font(.barlowCondensed(size: .subheadlineSize, weight: .medium))
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white)
                    .frame(height: 56)
                    .shadow(radius: 6)
                    .overlay {
                        TextField("Enter room name", text: $roomName)
                            .offset(x: 12)
                            .font(.barlow(size: .bodySize, weight: .regular))
                            .textFieldStyle(.plain)
                    }
                
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 14)
            ButtonView(
                backgroundColor: .amethystSmoke,
                foregroundColor: .white,
                text: "CREATE CLASSROOM",
                action: {
                    addClassroom()
                    withAnimation {
                        isPresented = false
                    }
                },
                cornerRadius: 8,
                size: .small
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 14)
            .disabled(roomName.isEmpty)
        }
        .padding(.vertical)
        .background(.whisper)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
    }
    
    private func addClassroom() {
        guard !roomName.isEmpty else { return }
        let classroom = Classroom(
            id: UUID().uuidString,
            roomName: roomName,
            school: Utils.currentEnvironment.apiKey,
            professor: nil,
            students: []
        )
        appManager.createClassroom(classroom)
    }
        
}

#Preview {
    AddClassroomView(isPresented: .constant(true))
        .environmentObject(AppManager())
        
}
