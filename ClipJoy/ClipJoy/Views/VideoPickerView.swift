//
//  VideoPickerView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 09/12/24.
//

import SwiftUI
import AVKit

struct VideoPickerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: VideoPickerView

        init(parent: VideoPickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[.mediaURL] as? URL {
                parent.completion(url)
            } else {
                parent.completion(nil)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.completion(nil)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) private var presentationMode
    var completion: (URL?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary // Use the Photos library
        picker.mediaTypes = ["public.movie"] // Restrict to video files
        picker.videoQuality = .typeMedium
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    VideoPickerView { selectedURL in
        if let url = selectedURL {
            print("Selected video URL: \(url)")
        } else {
            print("Video selection was canceled.")
        }
    }
}

