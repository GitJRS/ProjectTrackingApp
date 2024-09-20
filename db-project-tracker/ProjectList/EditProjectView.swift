//
//  EditProjectView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI
import SwiftData

struct EditProjectView: View {
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  
  @State private var projectName: String = ""
  @State private var showConfirmation: Bool = false
  var project: Project
  var isEditMode: Bool
  
  var body: some View {
    
    ZStack {
      
      Color.black
        .ignoresSafeArea()
      
      VStack (alignment: .leading) {
        
        Text(isEditMode ? "Edit Project" : "New Project")
          .foregroundStyle(.white)
          .font(.bigHeadline)
        
        HStack {
          
          TextField("Project name", text: $projectName)
            .textFieldStyle(.roundedBorder)
            .onChange(of: projectName) { oldValue, newValue in
              projectName = TextHelper.limitChars(input: projectName, limit: 30)
            }
          
          Button(isEditMode ? "Save" : "Add") {
            
            if isEditMode {
              // save new project name
              project.name = projectName
            } else {
              
              withAnimation {
                // add project to SwiftData
                project.name = projectName
                context.insert(project)
                
                // force a SwiftData save to show animation
                try? context.save()
              }
            }
            dismiss()
          }
          .buttonStyle(.borderedProminent)
          .tint(.blue)
          // ensure project has a name
          .disabled(projectName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
          
          if isEditMode {
            // show delete button
            Button("Delete") {
              // show confirmation
              showConfirmation = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
          }

        }
        
        Spacer()
      }
      .padding(.horizontal)
      .padding(.top)
    }
    .confirmationDialog("Really delete?", isPresented: $showConfirmation, titleVisibility: .visible) {
      Button("Yes, delete") {
        
        withAnimation {
          // delete project from SwiftData
          context.delete(project)
          
          // force a SwiftData save to show animation
          try? context.save()
        }
        
        dismiss()
      }
    }
    .onAppear {
      projectName = project.name
    }
  }
}

#Preview {
  EditProjectView(project: Project(), isEditMode: false)
}
