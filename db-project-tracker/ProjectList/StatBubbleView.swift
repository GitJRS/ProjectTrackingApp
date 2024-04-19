//
//  StatBubbleView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI

struct StatBubbleView: View {
  
  var title: String
  var stat: Double
  var gradientStartColor: Color
  var gradientEndColor: Color
  
  var body: some View {
    
    ZStack {
      
      RoundedRectangle(cornerRadius: 15)
        .fill(LinearGradient(
          colors: [gradientStartColor, gradientEndColor],
          startPoint: .topLeading,
          endPoint: .bottomTrailing))
      
      VStack {
        Text(title)
          .font(.captionText)
        Text(TextHelper.convertStat(input: stat))
          .font(.featuredNumber)
          .bold()
      }
      .foregroundStyle(.white)
    }
    .frame(width: 60, height: 40)
  }
}

#Preview {
  StatBubbleView(title: "Hours", stat: 290.0, gradientStartColor: Color("User Navy"), gradientEndColor: Color("User Blue"))
}
