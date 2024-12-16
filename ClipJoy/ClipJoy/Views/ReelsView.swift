//
//  ReelsView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 16/12/24.
//

import SwiftUI
import AVKit
import AVFoundation
import PhotosUI


struct ReelsView: View {
    @Binding var editedVideos: [URL]
    
    var body: some View {
        ScrollView {
            ForEach(editedVideos, id: \.self) { videoURL in
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

#Preview {
    ReelsView(editedVideos: .constant([]))
}
