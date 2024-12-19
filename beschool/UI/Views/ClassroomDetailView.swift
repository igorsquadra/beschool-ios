//
//  ClassroomDetailView.swift
//  beschool
//
//  Created by Igor Squadra on 19/12/24.
//

import SwiftUI

struct ClassroomDetailView: View {
    @EnvironmentObject var appManager: AppManager
    @Environment(\.dismiss) var dismiss
    @State private var classroom: Classroom
    @State private var showProfessorCreationView = false
    @State private var showStudentCreationView = false
    @State private var showProfessorDetailView: Professor?
    @State private var showStudentDetailView: Student?
    @State private var showDeleteAlert = false
    private var columns: [GridItem] {
        if Utils.isIpad {
            [GridItem(.adaptive(minimum: 140), spacing: 16)]
        } else {
            Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
        }
    }
    
    init(classroom: Classroom) {
        self.classroom = classroom
    }
    var body: some View {
        VStack(spacing: 14) {
            header
                .padding(.horizontal, 24)
            ScrollView {
                professorCard
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                students
                    .padding(.top, 10)
            }
        }
        .background(.whisper)
        .navigationBarBackButtonHidden()
        .showPopover(isPresented: $showStudentCreationView) {
            AddProfileView(
                isPresented: $showStudentCreationView,
                isProfessor: false,
                onCreate: { student in
                    if let student = student as? Student {
                        var updatedClassroom = classroom
                        updatedClassroom.students.append(student)
                        classroom = updatedClassroom
                        appManager.editClassroom(updatedClassroom)
                    }
                }
            )
                .environmentObject(appManager)
                .frame(
                    width: Utils.isIpad ? Screen.width * 0.5 : Screen.width * 0.9,
                    height: Screen.height
                )
        }
        .showPopover(isPresented: $showProfessorCreationView) {
            AddProfileView(
                isPresented: $showProfessorCreationView,
                isProfessor: true,
                onCreate: { professor in
                    if let professor = professor as? Professor {
                        classroom.professor = professor
                        appManager.editClassroom(classroom)
                    }
                }
            )
                .environmentObject(appManager)
                .frame(
                    width: Utils.isIpad ? Screen.width * 0.5 : Screen.width * 0.9,
                    height: Screen.height
                )
        }
        .navigationDestination(item: $showStudentDetailView, destination: { student in
            ProfileDetailView(profile: student)
        })
        .navigationDestination(item: $showProfessorDetailView, destination: { professor in
            ProfileDetailView(profile: professor)
        })
        .showAlert(
            $showDeleteAlert,
            title: "Delete Classroom",
            message: "Are you sure you want to delete this classroom?",
            actions: [
                .cancel,
                .custom(title: "Ok", action: {
                    deleteClassroom()
                })
            ]
        )
    }
    
    private func deleteClassroom() {
        appManager.deleteClassroom(id: classroom.id)
        dismiss()
    }
}

// MARK: - Components

extension ClassroomDetailView {
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
                IconButton(
                    icon: Image(.trash),
                    borderColor: .red,
                    backgroundColor: .whisper,
                    action: {
                        showDeleteAlert = true
                    },
                    animateRotation: false
                )
            }
            Text(classroom.roomName)
                .font(.barlowCondensed(size: .largeTitle1Size, weight: .bold))
        }
    }
    
    @ViewBuilder
    private var professorCard: some View {
        HStack {
            Text("PROFESSOR")
                .font(.barlowCondensed(size: .title3Size, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            IconButton(
                icon: Image(.plus),
                borderColor: .clear,
                backgroundColor: .whisper,
                action: {
                    showProfessorCreationView = true
                },
                animateRotation: false
            )
        }
        if let professor = classroom.professor {
            Button {
                showProfessorDetailView = professor
            } label: {
                HStack {
                    if let avatar = professor.avatar,
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
                            Circle().stroke(Color.yellow,
                                            lineWidth: 4
                                           )
                        )
                    }
                    Text(professor.name)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Text(professor.subjects.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                    
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .frame(maxWidth: 360)
            }
        }
    }
    
    @ViewBuilder
    private var students: some View {
        HStack {
            Text("STUDENTS")
                .font(.barlowCondensed(size: .title3Size, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            IconButton(
                icon: Image(.plus),
                borderColor: .clear,
                backgroundColor: .whisper,
                action: {
                    showStudentCreationView = true
                },
                animateRotation: false
            )
        }
        .padding(.horizontal, 24)
        if !classroom.students.isEmpty {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(classroom.students, id: \.id) { student in
                        ProfileCard(
                            avatar: student.avatar,
                            name: student.name,
                            description: student.notes ?? "",
                            isProfessor: false,
                            action: {
                                showStudentDetailView = student
                            },
                            isSelectable: false,
                            isSelected: false
                        )
                        .transition(
                            .scale(scale: 0.0, anchor: .center)
                            .combined(with: .opacity)
                        )
                        .animation(.easeOut(duration: 0.5), value: classroom.students)
                    }
                }
                .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ClassroomDetailView(classroom: PreviewData.classrooms.first!)
//    ClassroomDetailView(classroom: PreviewData.classrooms.last!)
}
