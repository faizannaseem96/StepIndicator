//
//  ViewController.swift
//  StepIndicator
//
//  Created by Yun Chen on 2017/7/14.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var stepIndicatorView:StepIndicatorView!
    @IBOutlet weak var scrollView:UIScrollView!
    
    private var isScrollViewInitialized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In this demo, the customizations have been done in Storyboard.
        
        // Customization by coding:
        self.stepIndicatorView.centerTextColor = .white
        self.stepIndicatorView.numberOfSteps = 5
        self.stepIndicatorView.currentStep = 0
        self.stepIndicatorView.circleColor = UIColor.red.withAlphaComponent(0.35)
        self.stepIndicatorView.circleTintColor = .blue
        self.stepIndicatorView.circleStrokeWidth = 10.0
        self.stepIndicatorView.circleRadius = 10.0
        self.stepIndicatorView.lineColor = .gray
        self.stepIndicatorView.lineTintColor = .brown
        self.stepIndicatorView.lineMargin = 4.0
        self.stepIndicatorView.lineStrokeWidth = 1.0
        self.stepIndicatorView.displayNumbers = true 
        self.stepIndicatorView.direction = .leftToRight
        self.stepIndicatorView.showFlag = true

        // Example for apply constraints programmatically, enable it for test.
        //self.applyNewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isScrollViewInitialized {
            isScrollViewInitialized = true
            self.initScrollView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initScrollView() {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(self.stepIndicatorView.numberOfSteps + 1), height: self.scrollView.frame.height)
        
        let labelHeight = self.scrollView.frame.height / 2.0
        let halfScrollViewWidth = self.scrollView.frame.width / 2.0
        
        for i in 1 ... self.stepIndicatorView.numberOfSteps + 1 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
            if i<=self.stepIndicatorView.numberOfSteps {
                label.text = "\(i)"
            }
            else{
                label.text = "You're done!"
            }
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 35)
            label.textColor = UIColor.lightGray
            label.center = CGPoint(x: halfScrollViewWidth * (CGFloat(i - 1) * 2.0 + 1.0), y:labelHeight)
            self.scrollView.addSubview(label)
        }
    }
    
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        stepIndicatorView.currentStep = Int(pageIndex)
    }
    
    
    // MARK: - More Examples
    
    // Example for applying constraints programmatically
    func applyNewConstraints() {
        // Hold the weak object
        guard let stepIndicatorView = self.stepIndicatorView else {
            return
        }
        
        // Remove the constraints made in Storyboard before
        stepIndicatorView.removeFromSuperview()
        stepIndicatorView.removeConstraints(stepIndicatorView.constraints)
        self.view.addSubview(stepIndicatorView)
        
        // Add new constraints programmatically
        stepIndicatorView.widthAnchor.constraint(equalToConstant: 263.0).isActive = true
        stepIndicatorView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        stepIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stepIndicatorView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant:30.0).isActive = true
    
        self.scrollView.topAnchor.constraint(equalTo: stepIndicatorView.bottomAnchor, constant: 8.0).isActive = true
    }
}

