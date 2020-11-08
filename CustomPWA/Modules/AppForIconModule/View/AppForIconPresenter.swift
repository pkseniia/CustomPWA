//
//  AppForIconPresenter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Foundation

protocol AppForIconPresenterProtocol: BasePresenterProtocol {
    var dataSourceCount: Int { get }
    func getObject(_ index: Int) -> CellObjectConfigurable?
    func pushSelectAppScreen()
    func createApp()
}

class AppForIconPresenter<View: AppForIconViewProtocol>: BasePresenter<View> {
    
    private let coordinator: CoordinatorProtocol
    private let servicesContainer: ServicesContainerProtocol
    private let getImageForAppUseCase: GetImageForAppUseCaseProtocol
    
    private var dataSource: [IconForAppCellObjectProtocol] = []
    
    init(view: View,
         coordinator: CoordinatorProtocol,
         servicesContainer: ServicesContainerProtocol,
         getImageForAppUseCase: GetImageForAppUseCaseProtocol) {
        self.coordinator = coordinator
        self.servicesContainer = servicesContainer
        self.getImageForAppUseCase = getImageForAppUseCase
        super.init(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setImage(with: getImageForAppUseCase.getImage())
        fillDataSource()
    }
    
    private func fillDataSource(entity: CustomAppEntity? = nil) {
        let appTitle = entity?.originalTitle ?? Constants.AppForIcon.chooseApplication
        let appImage = entity?.originalImage ?? .custom(name: .appleApp)
        let userTitle = entity?.title ?? Constants.AppForIcon.enterNameForApp
        dataSource = [
            AppIconTableViewCellObject(cellTitle: appTitle,
                                       cellImage: appImage),
            AppNameTableViewCellObject(cellTitle: userTitle,
                                       textFieldAction: { [weak self] newName in
                                        guard let self = self else { return }
                                        self.updateName(with: newName)
                                       })
        ]
        view.reloadTableView()
    }
    
    private func updateName(with name: String?) {
//        createAppEntity.title = name
//        view.enableCreateIconButton(with: createAppEntity.checkIfEntityIsReady())
    }
}

extension AppForIconPresenter: AppForIconPresenterProtocol {

    var dataSourceCount: Int { return dataSource.count }
    
    func getObject(_ index: Int) -> CellObjectConfigurable? {
        guard let object = dataSource[index] as? CellObjectConfigurable else { return nil}
        return object
    }
    
    func pushSelectAppScreen() {
        print("pushSelectAppScreen")
    }
    
    func createApp() {
        print("createApp")
    }
}

