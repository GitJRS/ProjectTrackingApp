//
//  AddProjectView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI
import SwiftData

struct AddProjectView: View {
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  
  @State var projectName: String = ""
  var project: Project
  
  var body: some View {
    
    ZStack {
      
      Color.black
        .ignoresSafeArea()
      
      VStack (alignment: .leading) {
        
        Text("New Project")
          .foregroundStyle(.white)
          .font(.bigHeadline)
        
        HStack {
          
          TextField("Project name", text: $projectName)
            .textFieldStyle(.roundedBorder)
          
          Button("Save") {
            // todo: save project to SwiftData
            project.name = projectName
            context.insert(project)
            dismiss()
          }
          .buttonStyle(.borderedProminent)
          .tint(.blue)

        }
        
        Spacer()
      }
      .padding(.horizontal)
      .padding(.top)
    }
  }
}

