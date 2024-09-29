protocol ResultsViewControllerProtocol: AnyObject {
    func reloadData(title: String)
    func stopProgressHud()
    func startProgressHud()
}
