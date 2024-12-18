//
//  PreviewData.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//

import Foundation

struct PreviewData {
    static let students: [Student] = [
        Student(
            id: "657c70f95c5d802dc52086f2",
            name: "Charlie Davis",
            email: "charlie.davis@student.com",
            avatar: "https://api.multiavatar.com/Charlie%20Davis.png",
            notes: "Very curious about biology."
        ),
        Student(
            id: "657c70f95c5d802dc52086f3",
            name: "Diana Lee",
            email: "diana.lee@student.com",
            avatar: "https://api.multiavatar.com/Diana%20Lee.png",
            notes: "Excellent in physics experiments."
        ),
        Student(
            id: "657c70f95c5d802dc52086f4",
            name: "Ethan Brown",
            email: "ethan.brown@student.com",
            avatar: "https://api.multiavatar.com/Ethan%20Brown.png",
            notes: "Quick learner in chemistry."
        ),
        Student(
            id: "657c70f95c5d802dc52086f5",
            name: "Grace Hopper",
            email: "grace.hopper@student.com",
            avatar: "https://api.multiavatar.com/Grace%20Hopper.png",
            notes: "Passionate about programming."
        ),
        Student(
            id: "657c70f95c5d802dc52086f6",
            name: "Henry Ford",
            email: "henry.ford@student.com",
            avatar: "https://api.multiavatar.com/Henry%20Ford.png",
            notes: "Loves designing experiments."
        )
    ]
    
    static let professor1: Professor = Professor(
        id: "657c70f95c5d802dc52086f1",
        name: "Dr. Jane Roe",
        email: "jane.roe@school.com",
        subjects: ["Physics", "Chemistry", "Biology"],
        avatar: "https://api.multiavatar.com/Jane%20Roe.png"
    )
    
    static let professor2: Professor = Professor(
        id: "657c70f95c5d802dc52086f1",
        name: "Dr. Mario Rossi",
        email: "mario.rossi@school.com",
        subjects: ["Mathematics", "Geometry"],
        avatar: "https://api.multiavatar.com/Mario%20Rossi.png"
    )
    
    static let classrooms: [Classroom] = [
        Classroom(
            id: "B2",
            roomName: "202",
            school: "High School",
            professor: professor1,
            students: Array(students.prefix(4))
        ),
        Classroom(
            id: "B3",
            roomName: "203",
            school: "High School",
            professor: professor2,
            students: Array(students.suffix(4))
        )
    ]
}
