//
//  AddProfileView.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct AddProfileView: View {
    @EnvironmentObject var appManager: AppManager
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var description: String = ""
    private let isProfessor: Bool
    private let onCreate: (any Profile) -> Void
    
    init(
        isPresented: Binding<Bool>,
        isProfessor: Bool,
        onCreate: @escaping (any Profile) -> Void
    ) {
        self._isPresented = isPresented
        self.isProfessor = isProfessor
        self.onCreate = onCreate
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(isProfessor ? "ADD NEW PROFESSOR" : "ADD NEW STUDENT")
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
                Text("\(isProfessor ? "PROFESSOR" : "STUDENT") NAME")
                    .font(.barlowCondensed(size: .subheadlineSize, weight: .medium))
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white)
                    .frame(height: 56)
                    .shadow(radius: 6)
                    .overlay {
                        TextField("Enter name", text: $name)
                            .offset(x: 12)
                            .font(.barlow(size: .bodySize, weight: .regular))
                            .textFieldStyle(.plain)
                    }
                Text("\(isProfessor ? "PROFESSOR" : "STUDENT") EMAIL")
                    .font(.barlowCondensed(size: .subheadlineSize, weight: .medium))
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white)
                    .frame(height: 56)
                    .shadow(radius: 6)
                    .overlay {
                        TextField("Enter email", text: $email)
                            .offset(x: 12)
                            .font(.barlow(size: .bodySize, weight: .regular))
                            .textFieldStyle(.plain)
                    }
                Text(isProfessor ? "PROFESSOR SUBJECTS" : "STUDENT NOTES")
                    .font(.barlowCondensed(size: .subheadlineSize, weight: .medium))
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white)
                    .frame(height: 56)
                    .shadow(radius: 6)
                    .overlay {
                        TextField(isProfessor ? "Matematics, Geometry ..." : "Tell something about the student...", text: $description)
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
                text: "CREATE \(isProfessor ? "PROFESSOR" : "STUDENT")",
                action: {
                    createProfile()
                    withAnimation {
                        isPresented = false
                    }
                },
                cornerRadius: 8,
                size: .small
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 14)
            .disabled(name.isEmpty)
        }
        .padding(.vertical)
        .background(.whisper)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
    }
                
    private func createProfile()  {
        if isProfessor {
            let professor = Professor(
                id: UUID().uuidString,
                name: name,
                email: email,
                subjects: description.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) },
                avatar: Utils.currentEnvironment.avatarBaseURL.appending(name)
            )
            onCreate(professor)
        } else {
            let student = Student(
                id: UUID().uuidString,
                name: name,
                email: email,
                avatar: Utils.currentEnvironment.avatarBaseURL.appending(name),
                notes: description
            )
            onCreate(student)
        }
    }
}

#Preview {
    AddProfileView(isPresented: .constant(true), isProfessor: false, onCreate: { _ in })
        .environmentObject(AppManager())
    AddProfileView(isPresented: .constant(true), isProfessor: true, onCreate: { _ in })
        .environmentObject(AppManager())
        
}
