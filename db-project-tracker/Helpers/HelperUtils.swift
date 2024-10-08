//
//  HelperUtils.swift
//  CitySights App
//
//  Created by MacBook2014 on 4/10/24.
//

import Foundation
import SwiftUI

// hex color conversion
extension Color {
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB 12bit
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB 24bit
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // RGB 32bit
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (1, 1, 1, 0)
    }
    
    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}

// DateHelper
struct DateHelper {
  
  static func convertDate(inputDate: Date) -> String {
    
    let df = DateFormatter()
    df.dateFormat = "EEEE, MMM d, yyyy"
    return df.string(from: inputDate)
  }
}

// TextHelper
struct TextHelper {
  
  static func convertStat(input: Double) -> String {
    
    switch (input) {
    case let stat where input > 1000000:
      let dividedStat = stat/1000000
      return "\(round(dividedStat * 10) / 10)M"
    case let stat where input > 1000:
      let dividedStat = stat/1000
      return "\(round(dividedStat * 10) / 10)K"
    default:
      return String(Int(input))
    }
  }
  
  static func limitChars(input: String, limit: Int) -> String {
    if input.count > limit {
      return String(input.prefix(limit))
    }
    return input
  }
}


