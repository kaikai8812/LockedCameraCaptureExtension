//
//  CaptureExtension.swift
//  CaptureExtension
//
//  Created by aoyamakai on 2024/09/21.
//

import Foundation
import LockedCameraCapture
import SwiftUI

@main
struct CaptureExtension: LockedCameraCaptureExtension {
    var body: some LockedCameraCaptureExtensionScene {
        LockedCameraCaptureUIScene { session in
            CaptureExtensionViewFinder(session: session)
        }
    }
}
