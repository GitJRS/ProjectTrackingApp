//
//  ProjectDetailView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
  
  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) private var dismiss
  
  @State private var newUpdate: ProjectUpdate?
  @State private var showEditFocus = false

  var project: Project
  
  var body: some View {
    
    ZStack {
      
      LinearGradient(
        colors: [Color("User Navy"), Color("User Blue")],
        startPoint: .top,
        endPoint: .bottom)
      .ignoresSafeArea()
      
      LinearGradient(
        colors: [Color("User Blue").opacity(0), Color("User Purple")],
        startPoint: .top,
        endPoint: .bottom)
      .frame(width: 1)
      .padding(.leading, -150)
      
      VStack {
        
        // header
        VStack(alignment: .leading, spacing: 13) {
          
          Text(project.name)
            .font(.screenHeading)
          
          HStack(alignment: .center, spacing: 13) {
            
            Spacer()
            
            StatBubbleView(title: "Hours", stat: project.hours, gradientStartColor: Color("User Navy"), gradientEndColor: Color("User Blue"))
            StatBubbleView(title: "Sessions", stat: Double(project.sessions), gradientStartColor: Color("User Green"), gradientEndColor: Color("User Dark Lime"))
            StatBubbleView(title: "Updates", stat: Double(project.updates.count), gradientStartColor: Color("User Maroon"), gradientEndColor: Color("User Purple"))
            StatBubbleView(title: "Wins", stat: Double(project.wins), gradientStartColor: Color("User Maroon"), gradientEndColor: Color("User Olive"))
            
            Spacer()
            
          }
          
          Text("My current focus is")
            .font(.featuredText)
          
          HStack {
            if (project.focus.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
              
              Button {
                completeMilestone()
              } label: {
                Image(systemName: "checkmark.square")
              }
            }
            
            Text(project.focus.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Tap to set focus" : project.focus)
              .font(.featuredText)
              .onTapGesture {
                // display edit focus form
                showEditFocus = true
              }
          }
          .padding(.leading)
        }
        .foregroundStyle(.white)
        .padding()
        .background {
          Color.black
            .opacity(0.7)
            .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
            .ignoresSafeArea()
        }
        
        //project updates
        if project.updates.count > 0 {
          ScrollView(showsIndicators: false) {
            
            VStack(spacing: 27) {
              
              ForEach(project.updates.sorted(by: { u1, u2 in
                u1.date > u2.date
              })) { update in
                ProjectUpdateView(update: update)
                  .onTapGesture {
                  }
                  .onLongPressGesture {
                    newUpdate = update
                  }
              }
            }
            .padding()
            .padding(.bottom, 80)
          }
        } else {
          Spacer()
          
          HStack {
            
            Spacer()
            
            Button("Tap to add an update") {
              newUpdate = ProjectUpdate()
            }
            .buttonStyle(.bordered)
            .foregroundStyle(.white)
            .font(.bigHeadline)
            
            Spacer()
          }
          
          Spacer()
          Spacer()
        }
      }
      
      VStack {
        
        Spacer()
        
        HStack {
          Button {
            
            // add project update
            newUpdate = ProjectUpdate()
          } label: {
            ZStack {
              Circle()
                .foregroundStyle(.black)
                .frame(width: 65)
              Image("cross")
            }
          }
          .padding([.leading, .top])
          
          Spacer()
          
          Button("Back") {
            dismiss()
          }
          .buttonStyle(.borderedProminent)
          .foregroundStyle(.white)
          .tint(.black)
          .padding([.trailing, .top])
        }
        .background {
          Color(.black)
            .opacity(0.5)
            .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
            .ignoresSafeArea()
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    .sheet(item: $newUpdate) { update in
      
      let isEdit = update.headline.trimmingCharacters(in: .whitespacesAndNewlines) != ""
      EditUpdateView(project: project, update: update, isEditMode: isEdit)
        .presentationDetents([.fraction(0.3)])
    }
    .sheet(isPresented: $showEditFocus) {
      EditFocusView(project: project)
        .presentationDetents([.fraction(0.2)])
    }
  }
  
  func completeMilestone() {
    
    // create a new project update for milestone
    let update = ProjectUpdate()
    update.updateType = .milestone
    update.headline = "Milestone Achieved"
    update.summary = project.focus
    project.updates.insert(update, at: 0)
    
    // force a SwiftData save
    try? context.save()
    
    // update stats
    StatHelper.updateAdded(project: project, update: update)
    // clear project focus
    project.focus = ""
  }
}

#Preview {
  ProjectDetailView(project: Project())
}
