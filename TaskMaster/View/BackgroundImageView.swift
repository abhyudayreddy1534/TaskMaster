//
//  BackgroundImageView.swift
//  TaskMaster
//
//  Created by Sravanthi Chinthireddy on 05/03/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}
