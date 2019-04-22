//
//  UIView+Reactive.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/22/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

import Bond
import ReactiveKit

public extension ReactiveExtensions where Base: UIView {

    var frame: SafeSignal<CGRect> {
        return self.keyPath("frame", ofExpectedType: CGRect.self).recover(with: CGRect.null)
    }

    var bounds: SafeSignal<CGRect> {
        return self.keyPath("bounds", ofExpectedType: CGRect.self).recover(with: CGRect.null)
    }

    var borderColor: Bond<UIColor?> {
        return self.bond { ctrl, value in
            ctrl.layer.borderColor = value?.cgColor
        }
    }
    var borderWidth: Bond<CGFloat> {
        return self.bond { ctrl, value in
            ctrl.layer.borderWidth = value
        }
    }

    var semanticContentAttribute: Bond<UISemanticContentAttribute> {
        return bond { button, semanticContentAttribute in
            button.semanticContentAttribute = semanticContentAttribute
        }
    }

    func endEditing(_ force: Bool) -> Bond<Void> {
        return self.bond {view, _ in
            view.endEditing(force)
        }
    }
}
