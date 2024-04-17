//
//  AddUpdateView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI
import SwiftData

struct AddUpdateView: View {
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  
  @State private var headline: String = ""
  @State private var summary: String = ""
  @State private var hours: String = ""
  
  var project: Project
  var update: ProjectUpdate
  
  var body: some View {
    
    ZStack {
      
      Color.black
        .ignoresSafeArea()
      
      VStack (alignment: .leading) {
        
        Text("New Update")
          .foregroundStyle(.white)
          .font(.bigHeadline)
        
        
        TextField("Headline", text: $headline)
        
        TextField("Summary", text: $summary, axis: .vertical)
        
        HStack {
          
          TextField("Hours", text: $hours)
            .keyboardType(.numberPad)
            .frame(width: 60)
          
          Button("Save") {
            
            // save update
            update.headline = headline
            update.summary = summary
            update.hours = Double(hours)!
            project.updates.insert(update, at: 0)
            dismiss()
          }
          .buttonStyle(.borderedProminent)
          .tint(.blue)
        }
                
        Spacer()
      }
      .textFieldStyle(.roundedBorder)
      .padding(.horizontal)
      .padding(.top)
    }
  }
}

#Preview {
  AddUpdateView(project: Project(), update: ProjectUpdate())
}
