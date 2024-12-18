//
//  AddClassroomView.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct AddClassroomView: View {
    @State private var roomName: String = ""
    let professors: [Professor] = []
        
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("ADD CLASSROOM")
                .font(.title2)
                .bold()
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("ROOM NAME")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.black)
                TextField("Enter room name", text: $roomName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)
            
            Text("PROFESSOR")
                .font(.caption)
                .bold()
                .foregroundColor(.black)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    ForEach(professors, id: \.id) { professor in
                        VStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.yellow)
                                .overlay(Circle().stroke(Color.red, lineWidth: 2))
                            
                            Text(professor.name)
                                .font(.footnote)
                                .bold()
                            
                            Text("Matematica, Geografia, Aritmetica")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
    }
}

#Preview {
    AddClassroomView()
}
