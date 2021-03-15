//
//  UserInteractionEnabled.swift
//  BlueprintUICommonControls
//
//  Created by Noah Blake on 3/15/21.
//

import BlueprintUI
import UIKit

/// `UserInteractionEnabled` conditionally enables user interaction of its wrapped element.
///
/// - Note: When user interaction is disabled, any elements within the wrapped element will become non-interactive.
public struct UserInteractionEnabled: Element {
    public var isEnabled: Bool
    public var wrappedElement: Element

    public init(_ isEnabled: Bool, wrapping element: Element) {
        self.isEnabled = isEnabled
        self.wrappedElement = element
    }

    public var content: ElementContent {
        ElementContent(child: wrappedElement)
    }

    public func backingViewDescription(bounds: CGRect, subtreeExtent: CGRect?) -> ViewDescription? {
        UIView.describe { config in
            config[\.isUserInteractionEnabled] = isEnabled
        }
    }
}

public extension Element {
    /// Conditionally disable user interaction of the wrapped element.
    ///
    /// - Note: When user interaction is disabled, any elements within the wrapped element will become non-interactive.
    func disabled(_ disabled: Bool = true) -> UserInteractionEnabled {
        UserInteractionEnabled(!disabled, wrapping: self)
    }

    /// Conditionally enable user interaction of the wrapped element.
    ///
    /// - Note: When user interaction is disabled, any elements within the wrapped element will become non-interactive.
    func enabled(_ enabled: Bool = true) -> UserInteractionEnabled {
        UserInteractionEnabled(enabled, wrapping: self)
    }
}
