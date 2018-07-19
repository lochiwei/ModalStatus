//
//  ModalStatusView.swift
//  ModalStatus
//
//  Created by pegasus on 2018/07/19.
//  Copyright © 2018年 Lo Chiwei. All rights reserved.
//

import UIKit

public class ModalStatusView: UIView {
    
    // MARK: - Properties
    let nibName = "ModalStatusView"
    var contentView: UIView!
    var timer: Timer?
    
    // MARK: - Outlets
    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var headlineLabel: UILabel!
    @IBOutlet private weak var subheadLabel: UILabel!
    
    // MARK: - Set Up View
    
    // for use in code
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // for use in interface builder
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        
        // create content view
        // 1. bundle for this framework
        let bundle = Bundle(for: type(of: self))
        // 2. references a compiled .xib file (ModalStatusView.xib)
        let nib = UINib(nibName: nibName, bundle: bundle)
        // 3. view inside the nib
        contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        // 4. add content view to the view hierarchy
        addSubview(contentView)
        
        // setup content view
        contentView.center = self.center
        contentView.autoresizingMask = []   // resizing not allowed
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.alpha = 0.0
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        // setup outlets
        headlineLabel.text = ""
        subheadLabel.text = ""
    }
    
    // MARK: - Dismiss self
    public override func didMoveToSuperview() {
        
        // fade in
        contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = .identity
        }) { (_) in
            // add a timer to fade out and remove the view
            self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
                UIView.animate(withDuration: 0.15, animations: {
                    self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    self.contentView.alpha = 0.0
                }, completion: { (_) in
                    self.removeFromSuperview()
                })
            }
        }
        
    }
    
    // MARK: - public API
    public func set(image: UIImage) {
        statusImage.image = image
    }
    
    public func set(headline text: String) {
        headlineLabel.text = text
    }
    
    public func set(subheading text: String) {
        subheadLabel.text = text
    }
    
}//end: ModalStatusView
