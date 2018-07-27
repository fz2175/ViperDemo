//
//  VPViewController.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import UIKit

protocol VPViewControllerProtocol: class {
    
    var presenter: VPPresenterInputProtocal? { get set }
    func didReceiveVipers(_ viewModel: VPViewModelProtocol)
    func didReceiveError(_ errorMsg: String)
    
}

enum State {
    case loading
    case loaded
    case error(String)
    case noData
}

class VPViewController: UIViewController {

    var presenter: VPPresenterInputProtocal?
    
    fileprivate var viewModel: VPViewModelProtocol?
    fileprivate var dataSource: VPVipersDataSource?
    
    var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                updateUIForLoading()
            case .loaded:
                updateUIForLoaded()
            case .noData:
                updateUIForNoData()
            case .error(let errorMsg):
                updateUIForError(errorMsg)
            }
        }
    }
    
    @IBOutlet weak var loadingView: VPLoadingView!
    @IBOutlet weak var msgView: VPMsgView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTableView()
        updateVipers()
        
    }

}

extension VPViewController: VPViewControllerProtocol {
    
    func didReceiveVipers(_ viewModel: VPViewModelProtocol) {
        
        self.viewModel = viewModel
        dataSource?.vpViewModel = viewModel
        updateTitle()
        state = viewModel.hasData() ? .loaded : .noData
        
    }
    
    func didReceiveError(_ errorMsg: String) {
        
        state = .error(errorMsg)
        
    }
    
}

//MARK: Private
extension VPViewController {
    
    fileprivate func setupTableView() {
        
        tableView.separatorStyle = .none
        dataSource = VPVipersDataSource()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
    }
    
    fileprivate func updateVipers() {
        
        state = .loading
        presenter?.updateVipers()
        
    }
    
    fileprivate func updateTitle() {
        
        title = viewModel?.getOverviewTitle()
        
    }
    
    //MARK: State update
    fileprivate func updateUIForLoading() {
        
        msgView.hide()
        tableView.isHidden = true
        loadingView.show()
        
    }
    
    fileprivate func updateUIForLoaded() {
        
        loadingView.hide()
        msgView.hide()
        tableView.reloadData()
        tableView.isHidden = false
        
    }
    
    fileprivate func updateUIForNoData() {
        
        tableView.isHidden = true
        loadingView.hide()
        let msgStr = "No Viper level Loaded"
        msgView.showWithMsg(msgStr)
        
    }
    
    fileprivate func updateUIForError(_ errorMsg: String) {
        
        loadingView.hide()
        msgView.showWithMsg(errorMsg)
        tableView.isHidden = true
        
    }
    
}
