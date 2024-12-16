//
//  KaraokeView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 16/12/24.
//

import SwiftUI
import AVKit
import AVFoundation
import PhotosUI

// Helper function to save a video file to the temporary directory
func saveVideoToTemporaryDirectory(data: Data) -> URL? {
    let tempDirectory = FileManager.default.temporaryDirectory
    let tempURL = tempDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
    do {
        try data.write(to: tempURL)
        return tempURL
    } catch {
        print("Error saving video to temporary directory: \(error.localizedDescription)")
        return nil
    }
}

struct KaraokeView: View {
    @Binding var selectedVideo: URL?
    @Binding var combinedAudio: URL?
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var isRecording = false

    var body: some View {
        VStack {
            if let selectedVideo = selectedVideo {
                VideoPlayer(player: AVPlayer(url: selectedVideo))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding()
            } else {
                Text("No Karaoke Video Selected")
                    .foregroundColor(.gray)
                    .padding()
            }

            Button(action: {
                isRecording.toggle()
                if isRecording {
                    startRecording()
                } else {
                    stopRecording()
                }
            }) {
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isRecording ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            PhotosPicker(selection: $selectedItem, matching: .videos) {
                Label("Select Karaoke Video", systemImage: "video")
            }
            .onChange(of: selectedItem) { newItem in
                if let newItem = newItem {
                    Task {
                        do {
                            if let videoData = try await newItem.loadTransferable(type: Data.self),
                               let tempURL = saveVideoToTemporaryDirectory(data: videoData) {
                                selectedVideo = tempURL
                            }
                        } catch {
                            print("Error loading video: \(error.localizedDescription)")
                        }
                    }
                }
            }
            .padding()
        }
        .padding()
    }

    func startRecording() {
        // Implement recording functionality
    }

    func stopRecording() {
        // Implement stop recording functionality and save the audio
    }
}

#Preview {
    KaraokeView(selectedVideo: .constant(nil), combinedAudio: .constant(nil))
}
