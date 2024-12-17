//
//  CameraView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//


import SwiftUI

struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VideoRecorderView { result in
            // Handle the result of the video recording here
            presentationMode.wrappedValue.dismiss()
        }
        .navigationTitle("Record Video")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    // Wrap in a NavigationStack to show navigation bars
//    NavigationStack {
//        CameraView()
//    }
//}
