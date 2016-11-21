//
//  ProductPageVC.swift
//  happer
//
//  Created by Charles Fournier on 04/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class ProductPageVC : UIPageViewController {
    
    var currentCircle = Circle.Unknown
    var productInteractor = ProductInteractor()
    var activityIndicator: UIActivityIndicatorView!
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newProductViewController(Circle.Silver),
                self.newProductViewController(Circle.Gold),
                self.newProductViewController(Circle.Platine),
                self.newProductViewController(Circle.Ruby),
                self.newProductViewController(Circle.Sapphire)]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductPresenter.register(self, events: .GetProductSuccess, .GetProductFailure)
        productInteractor.getProducts()
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        if case 0 ... orderedViewControllers.count - 1 = currentCircle.hashValue {
            let firstviewcontroller = orderedViewControllers[currentCircle.hashValue] as! ProductVC
            
            setViewControllers([firstviewcontroller], direction: .Forward, animated: true, completion: nil)
        } else {
            //TODO message d'erreur
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        delegate = self
        dataSource = self

        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target: self, action: #selector(popToRoot))
    }

    func popToRoot() {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = currentCircle.rawValue
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ProductPresenter.register(self, events: .GetProductSuccess, .GetProductFailure)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        ProductPresenter.unregisterAll(self)
    }
    
    func newProductViewController(circle: Circle) -> UIViewController {
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewControllerWithIdentifier("productVC")
        productVC.title = circle.rawValue
        //TODO: build product from circle
        return productVC
    }
    
    
}

extension ProductPageVC : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
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
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let vc = viewControllers![0]
        self.navigationItem.title = vc.title
    }
    
}

extension ProductPageVC : ProductEvent {
    
    func getProductSuccess() {
        activityIndicator.stopAnimating()
        for vc in orderedViewControllers as! [ProductVC] {
            vc.buildFromCircle(Circle.init(value: vc.title!))
        }
    }
    
    func getProductFailure(error: NSError) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction!) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
