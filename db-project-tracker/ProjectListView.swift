//
//  ProjectListView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/13/24.
//

import SwiftUI

struct ProjectListView: View {
    var body: some View {
        VStack {
            Image("cross")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            .font(Font.screenHeading)
            .foregroundStyle(Color("Dark Lime"))
        }
        .padding()
    }
}

#Preview {
    ProjectListView()
}
