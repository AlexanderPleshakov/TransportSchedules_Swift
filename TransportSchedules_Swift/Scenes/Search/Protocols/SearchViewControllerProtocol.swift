protocol SearchViewControllerProtocol: AnyObject {
    func stationsWereLoaded()
    func stopProgressHud()
    func startProgressHud()
    func reloadData()
}
