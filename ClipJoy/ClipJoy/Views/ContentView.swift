//
//  ContentView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 16/12/24.
//

import SwiftUI
import AVKit
import AVFoundation
import PhotosUI

struct ContentView: View {
    @State private var selectedVideo: URL? = nil
    @State private var combinedAudio: URL? = nil
    @State private var editedVideo: URL? = nil
    @State private var editedVideos: [URL] = []
    
    var body: some View {
        TabView {
            KaraokeView(selectedVideo: $selectedVideo, combinedAudio: $combinedAudio)
                .tabItem { Label("Karaoke", systemImage: "mic.fill") }
            
            VideoEditorView(combinedAudio: $combinedAudio, editedVideo: $editedVideo)
                .tabItem { Label("Editor", systemImage: "video.fill") }
            
            ReelsView(editedVideos: $editedVideos)
                .tabItem { Label("Reels", systemImage: "play.rectangle.fill") }
        }
    }
}

#Preview {
    ContentView()
}
