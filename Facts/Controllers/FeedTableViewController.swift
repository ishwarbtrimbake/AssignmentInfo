

import UIKit

class FeedTableViewController: UITableViewController {
    private let viewModel = FactsViewModel()
    private var facts: [Fact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        configureTableController()
        
        self.viewModel.onError = { [weak self] error in
            self?.showAlert(error)
        }
        
        self.viewModel.onFactsLoading = { [weak self] response in
            self?.locateFacts(response)
        }
        getFacts()
    }
    
    func configureTableController() {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
    }
    
    func getFacts() {
        viewModel.getFacts()
    }
    
    func locateFacts(_ response: FactsResponse) {
        guard let rows = response.rows, let title = response.title else {
            self.showAlert("Failed to get data.")
            return
        }
        self.title = title
        self.facts = rows
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension FeedTableViewController {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return facts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedCell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.feed = facts[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        view.backgroundColor = UIColor.lightText
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
