//
//  EditUpdateView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI
import SwiftData

struct EditUpdateView: View {
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  
  @State private var headline: String = ""
  @State private var summary: String = ""
  @State private var hours: String = ""
  @State private var showConfirmation = false
  
  var project: Project
  var update: ProjectUpdate
  var isEditMode: Bool
  
  var body: some View {
    
    ZStack {
      
      Color.black
        .ignoresSafeArea()
      
      VStack (alignment: .leading) {
        
        Text(isEditMode ? "Edit Update" : "New Update")
          .foregroundStyle(.white)
          .font(.bigHeadline)
        
        
        TextField("Headline", text: $headline)
        
        TextField("Summary", text: $summary, axis: .vertical)
        
        HStack {
          
          TextField("Hours", text: $hours)
            .keyboardType(.numberPad)
            .frame(width: 60)
          
          Button(isEditMode ? "Save" : "Add") {
            
            // add update
            update.headline = headline
            update.summary = summary
            update.hours = Double(hours)!
            
            if !isEditMode {
              // Add Update
              project.updates.insert(update, at: 0)
            }
            dismiss()
          }
          .buttonStyle(.borderedProminent)
          .tint(.blue)
          
          if isEditMode {
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
      .textFieldStyle(.roundedBorder)
      .padding(.horizontal)
      .padding(.top)
    }
    .confirmationDialog("Really delete update?", isPresented: $showConfirmation) {
      Button("Yes, delete") {
        project.updates.removeAll { u in
          u.id == update.id
        }
        dismiss()
      }
    }
    .onAppear {
      headline = update.headline
      summary = update.summary
      hours = String(Int(update.hours))
    }
  }
}

#Preview {
  EditUpdateView(project: Project(), update: ProjectUpdate(), isEditMode: false)
}
