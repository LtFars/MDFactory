//
//  BottomSheetController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 02/09/2022.
//

import UIKit

class BottomSheetController: UIViewController {

    enum PreferredSheetSizing: CGFloat {
        case fit = 0 // Fit, based on the view's constraints
        case small = 0.25
        case medium = 0.50
        case large = 0.75
        case fill = 1
    }

    private lazy var bottomSheetTransitioningDelegate = BottomSheetControllerDelegate(
        preferredSheetTopInset: preferredSheetTopInset,
        preferredSheetCornerRadius: preferredSheetCornerRadius,
        preferredSheetSizingFactor: preferredSheetSizing.rawValue,
        preferredSheetBackdropColor: preferredSheetBackdropColor
        
    )
        
//    override var additionalSafeAreaInsets: UIEdgeInsets {
//        get {
//            .init(
//                top: super.additionalSafeAreaInsets.top + preferredSheetCornerRadius/2,
//                left: super.additionalSafeAreaInsets.left,
//                bottom: super.additionalSafeAreaInsets.bottom,
//                right: super.additionalSafeAreaInsets.right
//            )
//        }
//        set {
//            super.additionalSafeAreaInsets = newValue
//        }
//    }

    override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            .custom
        }
        set { }
    }

    override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get {
            bottomSheetTransitioningDelegate
        }
        set { }
    }

    var preferredSheetTopInset: CGFloat = 24 {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetTopInset = preferredSheetTopInset
        }
    }

    var preferredSheetCornerRadius: CGFloat = 8 {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetCornerRadius = preferredSheetCornerRadius
        }
    }

    var preferredSheetSizing: PreferredSheetSizing = .small {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetSizingFactor = preferredSheetSizing.rawValue
        }
    }

    var preferredSheetBackdropColor: UIColor = .white {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetBackdropColor = preferredSheetBackdropColor
        }
    }

//    var tapToDismissEnabled: Bool = false {
//        didSet {
//            bottomSheetTransitioningDelegate.tapToDismissEnabled = tapToDismissEnabled
//        }
//    }
//
//    var panToDismissEnabled: Bool = false {
//        didSet {
//            bottomSheetTransitioningDelegate.panToDismissEnabled = panToDismissEnabled
//        }

//    }
}
