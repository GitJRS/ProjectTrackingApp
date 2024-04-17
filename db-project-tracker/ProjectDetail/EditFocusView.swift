//
//  EditFocusView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/16/24.
//

import SwiftUI

struct EditFocusView: View {
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  
  @State var focus: String = ""
  var project: Project
  
  var body: some View {
    
    ZStack {
      
      Color.black
        .ignoresSafeArea()
      
      VStack (alignment: .leading) {
        
        Text("Edit Project Focus")
          .foregroundStyle(.white)
          .font(.bigHeadline)
        
        HStack {
          
          TextField("Focus", text: $focus)
            .textFieldStyle(.roundedBorder)
          
          Button("Save") {
            
            // save focus
            project.focus = focus
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

#Preview {
    EditFocusView(project: Project())
}
