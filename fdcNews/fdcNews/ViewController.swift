//
//  ViewController.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var viewModel = NewsListViewModel()
    
    private lazy var headerView: HeaderView = {
        let myHeaderView = HeaderView(fontsize: 32)
        return myHeaderView
    }()
    
    private lazy var tableView: UITableView = {
        let myTableView = UITableView()
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.tableFooterView = UIView()
        myTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        myTableView.delegate = self
        myTableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshOperations), for: .valueChanged)
        // this is the replacement of implementing: "myTableView.addSubview(refreshControl)"
        myTableView.refreshControl = refreshControl
        
        return myTableView
    }()
    
    @objc func pullToRefreshOperations(refreshControl: UIRefreshControl) {
        //print("Refreshing...")
        fetchNews()
        refreshControl.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        fetchNewsCold()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //for header
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
        //for tableview
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    func fetchNews() {
        viewModel.getNews{ (_) in
            self.tableView.reloadData()
        }
    }
    
    func fetchNewsCold() {
        viewModel.getNewsCold{ (_) in
            self.tableView.reloadData()
        }
    }
    
    func fetchNewsPage() {
        viewModel.getNewsPage { (_) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.saveNews()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        let news = viewModel.newsVM[indexPath.row]
        cell?.newsVM = news
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard Reachability.isConnectedToNetwork() else {
            return
        }
        
        let news = viewModel.newsVM[indexPath.row]
        guard let url = URL(string: news.url) else {
            return
        }
        
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
        
        updateViewsCounter(row: indexPath.row)
                
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.newsVM.count-1 {
            print("Last cell reached!")
            fetchNewsPage()
        }
    }
    
    func updateViewsCounter(row: Int) {
        if (viewModel.newsVM[row].news.views != nil) {
            viewModel.newsVM[row].news.views!+=1
        } else {
            viewModel.newsVM[row].news.views = 1
        }
        self.tableView.reloadData()
    }
}

