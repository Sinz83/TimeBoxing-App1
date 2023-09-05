//
//  TimeBoxing_AppApp.swift
//  TimeBoxing App
//
//  Created by Sabrina Inzillo on 16.04.23.
//

import SwiftUI

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}


struct TimeBoxingView: View {
    @State private var taskName = ""
    @State private var selectedDate = Date()
    @State private var selectedTag: String? = nil
    @State private var tasks: [Task] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Task Information")) {
                        TextField("Task Name", text: $taskName)
                        DatePicker("Due Date", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        Picker(selection: $selectedTag, label: Text("Tag")) {
                            Text("Work").tag("Work")
                            Text("Personal").tag("Personal")
                        }
                    }
                    Section {
                        Button(action: {
                            tasks.append(Task(name: taskName, dueDate: selectedDate, tag: selectedTag))
                            taskName = ""
                            selectedDate = Date()
                            selectedTag = nil
                        }, label: {
                            Text("Add Task")
                        })
                    }
                }
                List {
                    ForEach(tasks) { task in
                        NavigationLink(destination: TaskDetailView(task: task, onDelete: {
                            tasks.removeAll(where: { $0.id == task.id })
                        })) {
                            TaskRow(task: task)
                        }
                    }
                }
                .navigationTitle("TimeBoxing App")
            }
        }
    }
}

struct TaskRow: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.name)
                .font(.headline)
            Text(task.dueDate, style: .relative)
                .foregroundColor(.secondary)
        }
    }
}

struct TaskDetailView: View {
    let task: Task
    let onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.name)
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text(task.dueDate, style: .relative)
                .foregroundColor(.secondary)
            if let tag = task.tag {
                Text(tag)
                    .font(.caption)
                    .padding(.top, 10)
            }
        }
        .navigationBarTitle(Text("Task Details"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                onDelete()
            }, label: {
                Image(systemName: "trash")
            })
        )
    }
}

struct Task: Identifiable {
    let id = UUID()
    let name: String
    let dueDate: Date
    let tag: String?
}

struct TimeBoxingView_Previews: PreviewProvider {
    static var previews: some View {
        TimeBoxingView()
    }
}
