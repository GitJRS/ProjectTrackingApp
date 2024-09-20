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
          // this is awful. only allows a max of 24. changes higher values to 24, and only allows 2 chars
            .onChange(of: hours) { oldValue, newValue in
              let num = Int(TextHelper.limitChars(input: hours, limit: 2)) ?? 0
              hours = num > 24 ? "24" : String(num)
            }
          
          Button(isEditMode ? "Save" : "Add") {
            
            // track difference in hours for an edit update
            let hoursDifference =  Double(hours)! - update.hours
            
            // add update
            update.headline = headline
            update.summary = summary
            update.hours = Double(hours)!
            
            if !isEditMode {
             
              withAnimation {
                
                // Add Update
                project.updates.insert(update, at: 0)
                
                // force a SwiftData save
                try? context.save()
                
                // update stats
                StatHelper.updateAdded(project: project, update: update)
              }
            } else {
              
              withAnimation {
                // edit update
                // update stats
                StatHelper.updateEdited(project: project, hoursDifference: hoursDifference)
              }
            }
            dismiss()
          }
          .buttonStyle(.borderedProminent)
          .tint(.blue)
          .disabled(shouldDisable())
          
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
        
        withAnimation {
          
          project.updates.removeAll { u in
            u.id == update.id
          }
          // force a SwiftData save
          try? context.save()
          // delete updates
          StatHelper.updateDeleted(project: project, update: update)
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
  
  private func shouldDisable() -> Bool {
    // if headline/summary/hours is empty, then disable saving
    return headline.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
    summary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
    hours.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}

#Preview {
  EditUpdateView(project: Project(), update: ProjectUpdate(), isEditMode: false)
}
