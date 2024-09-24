//
//  WidgetExtensionControl.swift
//  WidgetExtension
//
//  Created by aoyamakai on 2024/09/21.
//

import AppIntents
import SwiftUI
import WidgetKit

struct WidgetExtensionControl: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: "kaikai.LockedCameraCaptureSample.WidgetExtension") {
            ControlWidgetButton(action: CaptureIntent()) {
                Label("LockedCapture", systemImage: "camera.viewfinder")
            }
        }
        .displayName("カメラを起動")
    }
}

extension WidgetExtensionControl {
    struct Provider: ControlValueProvider {
        var previewValue: Bool {
            false
        }

        func currentValue() async throws -> Bool {
            let isRunning = true // Check if the timer is running
            return isRunning
        }
    }
}

struct StartTimerIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Start a timer"

    @Parameter(title: "Timer is running")
    var value: Bool

    func perform() async throws -> some IntentResult {
        // Start / stop the timer based on `value`.
        return .result()
    }
}
