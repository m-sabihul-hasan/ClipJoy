//
//  VideoEditorView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 16/12/24.
//

import SwiftUI
import AVKit
import AVFoundation
import PhotosUI

struct VideoEditorView: View {
    @Binding var combinedAudio: URL?
    @Binding var editedVideo: URL?
    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        VStack {
            if let combinedAudio = combinedAudio {
                Text("Audio Ready: \(combinedAudio.lastPathComponent)")
                    .padding()
            } else {
                Text("No Audio Selected")
                    .foregroundColor(.gray)
                    .padding()
            }

            PhotosPicker(selection: $selectedItem, matching: .videos) {
                Label("Select Video to Edit", systemImage: "video")
            }
            .onChange(of: selectedItem) { newItem in
                if let newItem = newItem {
                    Task {
                        do {
                            if let videoData = try await newItem.loadTransferable(type: Data.self),
                               let tempURL = saveVideoToTemporaryDirectory(data: videoData) {
                                editVideo(videoURL: tempURL)
                            }
                        } catch {
                            print("Error loading video: \(error.localizedDescription)")
                        }
                    }
                }
            }
            .padding()

            if let editedVideo = editedVideo {
                VideoPlayer(player: AVPlayer(url: editedVideo))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding()
            } else {
                Text("No Edited Video Yet")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .padding()
    }

    func editVideo(videoURL: URL) {
        // Implement video editing logic, combining `combinedAudio` with the selected video
        print("Video editing logic goes here for \(videoURL)")
    }
}

#Preview {
    VideoEditorView(combinedAudio: .constant(nil), editedVideo: .constant(nil))
}

