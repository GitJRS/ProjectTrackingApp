//
//  ProjectUpdateView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI

struct ProjectUpdateView: View {
  var body: some View {
    
    ZStack {
      
      Rectangle()
        .foregroundStyle(.black)
        .shadow(radius: 5, x: 0, y: 4)
      
      VStack(alignment: .leading, spacing: 10) {
        
        HStack {
          
          Text("Thursday, Spet 12, 2023")
            .padding(.leading)
          
          Spacer()
          
          Text("9 Hours")
            .padding(.trailing)
        }
        .padding(.vertical, 5)
        .background {
          Color("User Orchid")
        }
        
        Text("Project headline")
          .font(.smallHeadline)
          .padding(.horizontal)
        
        Text("Project summary Project summary Project summary Project summary Project summary Project summary Project summary Project summary Project summary Project summary Project summary Project summary ")
          .padding(.horizontal)
          .padding(.bottom)
      }
      .foregroundStyle(.white)
      .font(.regularText)
    }
    .clipShape(RoundedRectangle(cornerRadius: 15))
  }
}

#Preview {
  ProjectUpdateView()
}
