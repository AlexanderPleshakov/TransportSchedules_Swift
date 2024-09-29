protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(
        didChange station: Station?,
        type: SearchType
    )
}
