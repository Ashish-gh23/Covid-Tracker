//
//  FilterViewController.swift
//  COVID Tracker
//
//  Created by Ashish Ranjan on 22/04/22.
//

import UIKit

class FilterViewController: UIViewController,
                            UITableViewDelegate,
                            UITableViewDataSource {
    
    public var completion: ((State?) -> Void)? = nil
    
    private var states: [State] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Select State"
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchStates()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func didTapClose() {
        completion?(nil)
        dismiss(animated: true)
    }
    
    private func fetchStates() {
        APICaller.shared.getStateList { [weak self] result in
            switch result {
            case .success(let states):
                self?.states = states
            case .failure(let failure):
                dump(failure)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = states[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let state = states[indexPath.row]
        completion?(state)
        dismiss(animated: true)
    }
    
}
