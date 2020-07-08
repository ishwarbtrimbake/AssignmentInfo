import UIKit

/// This TableViewController shows list of facts.
class FeedTableViewController: UITableViewController {
    private let viewModel = FactsViewModel()
    private var facts: [Fact] = []
    
    // MARK: - View Life Cycle
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
    
    // MARK: - UI Configuration
    func configureTableController() {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
    }
     
    // MARK: - Networking
    func getFacts() {
        //Checks whether device is connected to internet or not.
        if !Connectivity.isConnectedToInternet {
            self.showAlert(Constants.Messages.internetConnectionFailure.localized())
            return
        }
        viewModel.getFacts()
    }
    
    /// This function validates response and locates data
    /// - Parameter response: FactResponse which has title and facts data.
    func locateFacts(_ response: FactsResponse) {
        guard let rows = response.rows, let title = response.title else {
            self.showAlert(Constants.Messages.dataFailure.localized())
            return
        }
        self.facts = rows
        
        DispatchQueue.main.async { [weak self] in
            self?.title = title
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else {
            let cell = FeedCell(style: .default, reuseIdentifier: FeedCell.identifier)
            cell.feed = facts[indexPath.section]
            return cell
        }
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
