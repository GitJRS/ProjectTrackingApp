//
//  ProjectListView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/13/24.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
  
  @State private var newProject: Project?
  @State private var selectedProject: Project?
  @Query private var projects: [Project]
  
  var body: some View {
    
    NavigationStack {
      
      ZStack {
        
        LinearGradient(
          colors: [Color("User Deep Purple"), Color("User Blush Pink")],
          startPoint: .top,
          endPoint: .bottom)
        .ignoresSafeArea()
        
        VStack (alignment: .leading) {
          
          Text("Projects")
            .font(Font.screenHeading)
            .foregroundStyle(.white)
          
          if projects.count > 0 {
            ScrollView (showsIndicators: false) {
              
              VStack (alignment: .leading, spacing: 26) {
                
                ForEach(projects) { p in
                  
                  ProjectCardView(project: p)
                    .onTapGesture {
                      selectedProject = p
                    }
                    .onLongPressGesture {
                      newProject = p
                    }
                }
              }
            }
          } else {
            
            Spacer()
            
            HStack {
              
              Spacer()
              
              Button("Tap to add a new project") {
                newProject = Project()
              }
              .buttonStyle(.bordered)
              .foregroundStyle(.white)
              .font(.bigHeadline)
              
              Spacer()
            }
            
            Spacer()
          }
        }
        .padding()
        
        VStack {
          
          Spacer()
          
          HStack {
            
            Button {
              
              // create new project
              self.newProject = Project()
              
            } label: {
              ZStack {
                
                Circle()
                  .frame(width: 65)
                  .foregroundStyle(Color.black)
                
                Image("cross")
              }
            }
            
            Spacer()
          }
        }
        .padding(.leading)
      }
      .navigationDestination(item: $selectedProject) { project in
        ProjectDetailView(project: project)
      }
    }
    .sheet(item: $newProject) { project in
      
      let isEdit = project.name.trimmingCharacters(in: .whitespacesAndNewlines) != ""
      
      EditProjectView(project: project, isEditMode: isEdit)
        .presentationDetents([.fraction(0.2)])
      
    }
  }
}

#Preview {
  ProjectListView()
}
