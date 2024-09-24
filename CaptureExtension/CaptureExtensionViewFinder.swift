//
//  CaptureExtensionViewFinder.swift
//  CaptureExtension
//
//  Created by aoyamakai on 2024/09/21.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers
import LockedCameraCapture

struct CaptureExtensionViewFinder: UIViewControllerRepresentable {
    let session: LockedCameraCaptureSession
    var sourceType: UIImagePickerController.SourceType = .camera
    private let delegate: ImagePickerDelegate
    
    init(session: LockedCameraCaptureSession) {
        self.session = session
        self.delegate = .init(session: session)
    }
    
    func makeUIViewController(context: Self.Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = [UTType.image.identifier, UTType.movie.identifier]
        imagePicker.cameraDevice = .rear
        imagePicker.delegate = self.delegate
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Self.Context) {
    }
}

private class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let session: LockedCameraCaptureSession
    
    init(session: LockedCameraCaptureSession) {
        self.session = session
    }
    
    @MainActor
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        do {
            let fileURL = self.session.sessionContentURL.appendingPathComponent("LockedCapture")
            try pickedImage.jpegData(compressionQuality: 0.7)?.write(to: fileURL)
            
            Task {
                let activity = NSUserActivity(activityType: NSUserActivityTypeLockedCameraCapture)
                try await self.session.openApplication(for: activity)
            }
        } catch {
            debugPrint(error)
        }
    }
}
