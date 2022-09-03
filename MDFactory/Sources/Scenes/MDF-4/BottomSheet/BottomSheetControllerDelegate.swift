//
//  BottomSheetControllerDelegate.swift
//  MDFactory
//
//  Created by Andrei Maskal on 02/09/2022.
//

import UIKit

// MARK: BottomSheetTransitioningDelegate

final class BottomSheetControllerDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private weak var bottomSheetPresentationController: BottomSheetPresentationController?
    
    var preferredSheetTopInset: CGFloat
    var preferredSheetCornerRadius: CGFloat
    var preferredSheetSizingFactor: CGFloat
    var preferredSheetBackdropColor: UIColor
    
    var tapToDismissEnabled: Bool = true {
        didSet {
            bottomSheetPresentationController?.tapGestureRecognizer.isEnabled = tapToDismissEnabled
        }
    }
    
    init(
        preferredSheetTopInset: CGFloat,
        preferredSheetCornerRadius: CGFloat,
        preferredSheetSizingFactor: CGFloat,
        preferredSheetBackdropColor: UIColor
    ) {
        self.preferredSheetTopInset = preferredSheetTopInset
        self.preferredSheetCornerRadius = preferredSheetCornerRadius
        self.preferredSheetSizingFactor = preferredSheetSizingFactor
        self.preferredSheetBackdropColor = preferredSheetBackdropColor
        super.init()
    }
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let bottomSheetPresentationController = BottomSheetPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source,
            sheetTopInset: preferredSheetTopInset,
            sheetCornerRadius: preferredSheetCornerRadius,
            sheetSizingFactor: preferredSheetSizingFactor,
            sheetBackdropColor: preferredSheetBackdropColor
        )
        
        bottomSheetPresentationController.tapGestureRecognizer.isEnabled = tapToDismissEnabled
        
        self.bottomSheetPresentationController = bottomSheetPresentationController
        
        return bottomSheetPresentationController
    }
}

// MARK: BottomSheetPresentationController

final class BottomSheetPresentationController: UIPresentationController {
    
    private lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = sheetBackdropColor
        view.alpha = 0
        return view
    }()
    
    let sheetTopInset: CGFloat
    let sheetCornerRadius: CGFloat
    let sheetSizingFactor: CGFloat
    let sheetBackdropColor: UIColor
    
    private(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        gesture.cancelsTouchesInView = false
        return gesture
    }()
    
    init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        sheetTopInset: CGFloat,
        sheetCornerRadius: CGFloat,
        sheetSizingFactor: CGFloat,
        sheetBackdropColor: UIColor
    ) {
        self.sheetTopInset = sheetTopInset
        self.sheetCornerRadius = sheetCornerRadius
        self.sheetSizingFactor = sheetSizingFactor
        self.sheetBackdropColor = sheetBackdropColor
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    @objc private func onTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard
            let presentedView = presentedView,
            let containerView = containerView,
            !presentedView.frame.contains(gestureRecognizer.location(in: containerView))
        else {
            return
        }
        
        presentingViewController.dismiss(animated: true)
    }
    
    // MARK: UIPresentationController
    
    override func presentationTransitionWillBegin() {
        guard let presentedView = presentedView else {
            return
        }
        
        presentedView.layer.cornerRadius = sheetCornerRadius
        presentedView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        guard let containerView = containerView else {
            return
        }
        
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        containerView.addSubview(backdropView)
        
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(presentedView)
        
        presentedView.translatesAutoresizingMaskIntoConstraints = false
        
        let preferredHeightConstraint = presentedView.heightAnchor.constraint(
            equalTo: containerView.safeAreaLayoutGuide.heightAnchor,
            multiplier: sheetSizingFactor
        )
        
        preferredHeightConstraint.priority = .fittingSizeLevel
        let bottomConstraint = presentedView.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor
        )
        
        NSLayoutConstraint.activate([
            presentedView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            presentedView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            bottomConstraint,
            preferredHeightConstraint
        ])
    }
}








