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
        return myTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        fetchNews()
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
        let news = viewModel.newsVM[indexPath.row]
        guard let url = URL(string: news.url) else {
            return
        }
        
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
        
                
    }
}

