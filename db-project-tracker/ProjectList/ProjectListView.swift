//
//  ProjectListView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/13/24.
//

import SwiftUI

struct ProjectListView: View {
  var body: some View {
    
    ZStack {
      
      LinearGradient(
        colors: [Color("Deep Purple"), Color("Blush Pink")],
        startPoint: .top,
        endPoint: .bottom)
      .ignoresSafeArea()
      
      VStack (alignment: .leading) {
        
        Text("Projects")
          .font(Font.screenHeading)
          .foregroundStyle(.white)
        
        ScrollView (showsIndicators: false) {
          
          VStack (alignment: .leading, spacing: 26) {
            
            ProjectCardView()
            ProjectCardView()
            ProjectCardView()
          }
          
          
        }
      }
      .padding()
      
      VStack {
        
        Spacer()
        
        HStack {
          
          Button {
            // todo
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
}

#Preview {
  ProjectListView()
}
