//
//  VideoRecorderView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//


import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct VideoRecorderView: UIViewControllerRepresentable {
    var completion: (URL?) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        // Use UTType.movie from UniformTypeIdentifiers instead of kUTTypeMovie
        picker.mediaTypes = [UTType.movie.identifier]
        picker.cameraCaptureMode = .video
        picker.videoQuality = .typeMedium
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: VideoRecorderView

        init(_ parent: VideoRecorderView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let mediaURL = info[.mediaURL] as? URL {
                parent.completion(mediaURL)
            } else {
                parent.completion(nil)
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.completion(nil)
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

//#Preview {
//    VideoRecorderView { result in
//        // Handle the recorded video URL here
//        print("Recorded video URL: \(String(describing: result))")
//    }
//}
