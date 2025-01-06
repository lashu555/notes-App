//
//  CustomPush.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 05.01.25.
//

import UIKit

class CustomPush: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        0.25
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard
        let noteList = transitionContext.view(forKey: .from),
        let noteDetail = transitionContext.view(forKey: .to)
        else {return}
        
        let containerView = transitionContext.containerView
        
        noteDetail.transform = CGAffineTransform(scaleX: 0.5, y: 0.2)
        containerView.addSubview(noteDetail)
        
//        let darkOverlay = UIView(frame: noteList.bounds)
//            darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(0)
//        noteList.addSubview(darkOverlay)
        noteDetail.layer.cornerRadius = 12
        noteDetail.layer.shadowColor = UIColor.black.cgColor
        noteDetail.layer.shadowOffset = CGSize(width: 0, height: 2)
        noteDetail.layer.shadowRadius = 20
        noteDetail.layer.shadowOpacity = 0.2
        
        UIView.animate(
        withDuration: transitionDuration(using: transitionContext),
        delay: 0,
        options: .curveEaseOut, animations: {
            noteList.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
//            darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            noteDetail.transform = .identity
        },
        completion: { finished in
            noteList.transform = CGAffineTransform(scaleX: 1, y: 1)
//            darkOverlay.removeFromSuperview()
            noteDetail.layer.cornerRadius = 0
            noteDetail.layer.shadowColor = UIColor.black.cgColor
            noteDetail.layer.shadowOffset = CGSize(width: 0, height: 0)
            noteDetail.layer.shadowRadius = 0
            transitionContext.completeTransition(finished)
        })
    }
    
}
