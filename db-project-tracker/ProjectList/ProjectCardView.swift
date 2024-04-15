//
//  ProjectCardView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI

struct ProjectCardView: View {
  
  var body: some View {
    
    ZStack (alignment: .leading) {
      
      RoundedRectangle(cornerRadius: 15)
        .opacity(0.7)
        .shadow(radius: 5, x: 0, y: 4)
      
      VStack (alignment: .leading, spacing: 10) {
        
        Text("CodeWithChris")
          .font(.bigHeadline)
          .foregroundStyle(.white)
        
        HStack (alignment: .center) {
          
          Spacer()
          
          StatBubbleView(title: "Hours", stat: "290", gradientStartColor: Color("Navy"), gradientEndColor: Color("Blue"))
          StatBubbleView(title: "Sessions", stat: "34", gradientStartColor: Color("Green"), gradientEndColor: Color("Dark Lime"))
          StatBubbleView(title: "Updates", stat: "32", gradientStartColor: Color("Maroon"), gradientEndColor: Color("Purple"))
          StatBubbleView(title: "Wins", stat: "9", gradientStartColor: Color("Maroon"), gradientEndColor: Color("Olive"))
          
          Spacer()
        }
        
        Text("My current focus is...")
          .font(.featuredText)
          .foregroundStyle(.gray)
        Text("Design the new website")
          .font(.featuredText)
          .foregroundStyle(.gray)
          .bold()
      }
      .padding()
    }
  }
}

#Preview {
  ProjectCardView()
}
