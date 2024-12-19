//
//  SearchView.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct SearchView: View {
    @EnvironmentObject var appManager: AppManager
    @State private var showProfessorDetailView: Professor?
    @State private var showStudentDetailView: Student?
    @State private var searchText: String = ""
    @State private var results: [any Profile] = []
    
    private var columns: [GridItem] {
        if Utils.isIpad {
            [GridItem(.adaptive(minimum: 140), spacing: 16)]
        } else {
            Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("SEARCH")
                    .font(.barlowCondensed(size: .largeTitle2Size, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white)
                    .frame(height: 56)
                    .shadow(radius: 6)
                    .overlay {
                        TextField("Search profile", text: $searchText)
                            .offset(x: 12)
                            .font(.barlow(size: .bodySize, weight: .regular))
                            .textFieldStyle(.plain)
                    }
                    .padding(.horizontal, 24)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(results, id: \.id) { result in
                            if let student = result as? Student {
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
                            } else if let professor = result as? Professor {
                                ProfileCard(
                                    avatar: professor.avatar,
                                    name: professor.name,
                                    description: professor.subjects.joined(separator: ", "),
                                    isProfessor: true,
                                    action: {
                                        showProfessorDetailView = professor
                                    },
                                    isSelectable: false,
                                    isSelected: false
                                )
                                .transition(
                                    .scale(scale: 0.0, anchor: .center)
                                    .combined(with: .opacity)
                                )
                            }
                            
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding(.top, 26)
            .background(.whisper)
            .navigationDestination(item: $showStudentDetailView, destination: { student in
                ProfileDetailView(profile: student)
            })
            .navigationDestination(item: $showProfessorDetailView, destination: { professor in
                ProfileDetailView(profile: professor)
            })
            .onChange(of: searchText) { oldValue, newValue in
                if newValue.count > 2 {
                    let searchResults = appManager.searchProfiles(for: newValue)
                    withAnimation {
                        self.results = searchResults
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
