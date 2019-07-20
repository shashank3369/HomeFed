//
//  TutorialPageViewController.swift
//  HomeFed
//
//  Created by Kothapalli on 7/4/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    var pageControl = UIPageControl()
    var currentIndex: Int = 0
    var exitButton = UIButton()
    var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        configurePageControl()
        configureExitButton()
        configureSignupButton()
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.tutorialPageViewController(name: "SOP"),
                self.tutorialPageViewController(name: "HealthPermit"),
                self.tutorialPageViewController(name: "FoodSafety"),
                self.tutorialPageViewController(name: "Inspection")]
    }()
    
    private func tutorialPageViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: name)
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = currentIndex
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func configureExitButton() {
        exitButton = UIButton(frame: CGRect(x: 30, y: 60, width: 50, height: 50))
        exitButton.setTitle("Exit", for: .normal)
        exitButton.setTitleColor(UIColor.black, for: .normal)
        exitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(exitButton)
    }
    
    @objc func buttonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureSignupButton() {
        signUpButton.frame = CGRect(x: self.view.frame.size.width - 110, y: 60, width: 100, height: 50)
        signUpButton.setTitleColor(UIColor.black, for: .normal)
        signUpButton.setTitle("Signup", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        self.view.addSubview(signUpButton)
    }
    
    @objc func signUpButtonAction() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUp") as? SignupViewController else {
            return
        }
        
        present(vc, animated: true, completion: nil)
    }
}

// MARK: UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        if (currentIndex != 0) {
            currentIndex -= 1
        }
        
        pageControl.currentPage = currentIndex
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        if (currentIndex != orderedViewControllersCount - 1) {
            currentIndex += 1
        }
        
        pageControl.currentPage = currentIndex
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
