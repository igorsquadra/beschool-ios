import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appManager: AppManager
    @State private var classrooms: [Classroom] = []
    @State private var showAddClassroomView: Bool = false
    @State private var showClassroomDetail: Classroom?
    
    private var columns: [GridItem] {
        if Utils.isIpad {
            [GridItem(.adaptive(minimum: 200), spacing: 16)]
        } else {
            Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                header
                    .padding(.horizontal, 24)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(classrooms, id: \.id) { classroom in
                            ClassroomCard(
                                classroomName: classroom.roomName,
                                professorName: classroom.professor?.name ?? "-",
                                students: classroom.students,
                                action: {
                                   showClassroomDetail = classroom
                                }
                            )
                            .transition(
                                .scale(scale: 0.0, anchor: .center)
                                .combined(with: .opacity)
                            )
                            .animation(.easeOut(duration: 0.5), value: classrooms)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                }
            }
            .padding(.top, 26)
            .background(.whisper)
            .task {
                await loadClassrooms()
            }
            .onChange(of: appManager.classroomsUpdated) {
                Task {
                    await loadClassrooms()
                }
            }
            .navigationDestination(item: $showClassroomDetail, destination: { classroom in
                ClassroomDetailView(classroom: classroom)
                    .environmentObject(appManager)
            })
            .showPopover(isPresented: $showAddClassroomView) {
                AddClassroomView(isPresented: $showAddClassroomView)
                    .environmentObject(appManager)
                    .frame(
                        width: Utils.isIpad ? Screen.width * 0.5 : Screen.width * 0.9,
                        height: Screen.height
                    )
            }
        }
    }
    
    // MARK: - Methods
    
    private func loadClassrooms() async {
        do {
            let fetchedClassrooms = try await appManager.getClassrooms()
            withAnimation(.easeInOut(duration: 0.4)) {
                classrooms = fetchedClassrooms
            }
            appManager.classroomsUpdated = false
        } catch {
            print("Error fetching classrooms: \(error)")
        }
    }
    
    private func refreshData() {
        Task {
            try await appManager.syncAll()
        }
    }
}

// MARK: - Components

extension HomeView {
    private var header: some View {
        HStack {
            Text("MYSCHOOL")
                .font(.barlowCondensed(size: .largeTitle2Size, weight: .bold))
            Spacer()
            trailingItems
        }
    }
    
    private var trailingItems: some View {
        HStack(spacing: 12) {
            IconButton(
                icon: Image(.refresh),
                borderColor: .black,
                backgroundColor: .clear,
                action: {
                    refreshData()
                },
                animateRotation: true
            )
            IconButton(
                icon: Image(.plus),
                borderColor: .clear,
                backgroundColor: .whisper,
                action: {
                    withAnimation {
                        showAddClassroomView = true
                    }
                },
                animateRotation: false
            )
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppManager())
}
