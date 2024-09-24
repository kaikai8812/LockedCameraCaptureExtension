//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by aoyamakai on 2024/09/21.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetExtension()
        WidgetExtensionControl()
    }
}
