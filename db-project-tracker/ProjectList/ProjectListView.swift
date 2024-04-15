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
          
          ScrollView (showsIndicators: false) {
            
            VStack (alignment: .leading, spacing: 26) {
              
              ForEach(projects) { p in
                
                NavigationLink {
                  ProjectDetailView(project: p)
                } label: {
                  ProjectCardView(project: p)
                }
                .buttonStyle(.plain)
              }
            }
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
    }
    .sheet(item: $newProject) { project in
      AddProjectView(project: project)
        .presentationDetents([.fraction(0.2)])
      
    }
  }
}

#Preview {
  ProjectListView()
}
