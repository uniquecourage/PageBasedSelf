//
//  ModelController.swift
//  PageBasedSelf
//
//  Created by 林金龍 on 2015/9/1.
//  Copyright (c) 2015年 林金龍. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var pageData = NSArray()


    override init() {
        super.init()
        // Create the data model.
        var title:Array<String> = ["傲笑紅塵","青陽子","風之痕","亂世狂刀"]
        var weapon:Array<String> = ["劍","扇","劍","刀"]
        var poem1 = "寒劍默聽君子意，\n傲視人間笑紅塵。"
        var poem2 = "三教原本道為首，\n焉能平坐共齊名。"
        var poem3 = "堪尋對手共論劍，\n高處不勝寒。"
        var poem4 = "一簫一劍平生意，\n負盡狂名十五年。"
        var poem:Array<String> = [poem1,poem2,poem3,poem4]
        var content:Array<String> = []
        for var i:Int=0 ; i<4 ; i++ {
            content.append(title[i] + "|" + weapon[i] + "|" + poem[i] + "|")
        }
        pageData = [content[0],content[1],content[2],content[3]]
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.dataObject = self.pageData[index]
        return dataViewController
    }

    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataObject: AnyObject = viewController.dataObject {
            return self.pageData.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

