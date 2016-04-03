//
//  SFFeedListController.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit
import Alamofire
import DGElasticPullToRefresh

class SFFeedListController: UITableViewController {

    var detailViewController: SFArticleDetailController? = nil
    var objects = [SFFeedProtocol]() {
        didSet {
//            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(SFFeedListController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? SFArticleDetailController
        }
        
        let allFeeds = SFModelManager.sharedInstatnce.getAllFeeds()
        for feed in allFeeds {
            insertObject(nil, object: feed)
        }
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            var counter = allFeeds.count - 1

            for index in 0...counter {
                let feed = allFeeds[index]
                SFNetworkManager.sharedInstatnce.feelFeedRss((feed.link)!, completionHandler: { (result, error) in
                    if error == nil {
                        self!.objects[index] = result!
                        counter -= 1
                        if counter == 0 {
                            self?.tableView.reloadData()
                            self?.tableView.dg_stopLoading()

                        }
                    }
                })
            }

            
            
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject?) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : SFBrowseController = storyboard.instantiateViewControllerWithIdentifier("SFBrowseController") as! SFBrowseController
        vc.completionHandler = {
            (arg:Dictionary<String, [String]>) -> Void in
            
            
            for (type, list) in arg {
                if (type == FeedType.kRSS) {
                    for url in list {
                        SFNetworkManager.sharedInstatnce.feelFeedRss(url) { (result, error) in
                            if error == nil {
                                self.insertObject(sender, object: result!)
                            }
                        }
                    }
                } else if (type == FeedType.kAtom) {
                    for url in list {
                        SFNetworkManager.sharedInstatnce.feelFeedAtom(url) { (result, error) in
                            if error == nil {
                                self.insertObject(sender, object: result!)
                            }
                        }
                    }
                }
            }
        }
                    
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

    func insertObject(sender: AnyObject?, object:SFFeedProtocol) {
        objects.append(object)
        let indexPath = NSIndexPath(forRow: objects.count - 1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFeed" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] 
                let controller = segue.destinationViewController as! SFFeedDetailListController
                controller.selectedFeed = object
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.title
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let deletedObject = objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            SFModelManager.sharedInstatnce.deleteFeedAsync(deletedObject.feedId)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


    deinit {
        self.tableView.dg_removePullToRefresh()
    }

}

