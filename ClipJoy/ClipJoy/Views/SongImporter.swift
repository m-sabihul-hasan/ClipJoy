//
//  SongImporter.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//


import SwiftUI
import UniformTypeIdentifiers
import UIKit

struct SongImporter: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var onCompletion: (URL?) -> Void

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let types = [UTType.audio, UTType.mp3, UTType.wav]
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: types)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: SongImporter

        init(parent: SongImporter) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.onCompletion(urls.first)
            parent.presentationMode.wrappedValue.dismiss()
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.onCompletion(nil)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}