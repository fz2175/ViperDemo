# ViperDemo

This app is a demo to show an VIPER design pattern.

The app does a fake network call and get json response from vipers.json file and display it in TableView

The root folder contains 3 folders: 

	1. ViperModule folder: I assume this small app is just a module of a large app. So I called it ViperModule, which contains files for VIPER classes for this module. "VP" prefix indicates Invest.

	2. Network folder: Since there is no actual network calls for this demo app, I created a MockURLSession, which simulates the network call. It will return the json file as repsonse after 1.5 sec

	3. Helpers folder: Other helper classes which could benefit all modules in one large project.

Details for the design pattern 

	VPViewController has four states: loading, loaded, error and noData to display different views.

	1. AppDelegate will first generate a instance of VPViewController through VPRouter class

	2. VPViewController calls viewDidLoad, VPViewController has loading state.

	2. VPViewController make the calls to fetchVipers in ViewDidLoad

	3. VPViewController ask VPPresenter to fetchVipers through VPPresenterInputProtocol

	3. VPPresenter notifies VPInteractor class through VPInteractorInputProtocol

	4. VPInteractor interact with low level ApiConnection class to make mock network calls and get either success json response or error through ApiConnectionProtocol

	5. ApiConnection notifies VPInteractor the raw json data through ApiconnectionOutputProtocal

	6. VPInteractor converts the raw json data to ViperModel and notifies VPPresenter the results through VPPresenterOutputProtocal

	7. VPPresenter converts the ViperModel to VPViewModel and notifies VPViewController through VPViewControllerProtocol

	8. VPViewController will update its state based on the results and updates UI based on the value from VPViewModel

	9. TableView will reload data from VPViewModel

	10. VPImageView will get image url from VPCellViewModel

	11. VPImageView will check if the image has been cached from ImageCacheManager through ImageCacheManagerProtocol

	12. If image is not cached, VPImageView will ask ImageDownloadManager to download the image through ImageDownloadManagerProtocol

	13. ImageDownloadManager will ask low level ApiConnection class to download the image through ApiConnectionProtocal

	14. Once the image is downloaded, ApiConnection will notify ImageDownloadManager through ApiconnectionOutputProtocal

	15. ImageDownloadManager will notify VPImageView the response through VPImageViewOutputProtocol

	16. VPImageView will update image and cache the image to ImageCacheManager through ImageCacheManagerProtocol

	17. While image is downloading and the tableViewCell end displaying, VPImageView will ask ImageCacheManger to cancel downloading image througth ImageDownloadManagerProtocol

	18. ImageCacheManger will ask low level ApiConnection class to cancel download the image through ApiConnectionProtocal
	
For Testing:

	1. ApiconnectionTest class has following tests:

		testGetResumeCalled
		testURLStrSame
		testShouldReturnData
		testShouldReceiveError
		testRequestCancel

	2. VPInteractorTest class creates mock VPPresenter and mock Apiconnection with following tests:

		testFetchVipersSucceed
		testFetchVipersFails

	3. VPPresenterTest class creates mock VPInteractor and mock VPViewController with following tests:

		testFetchVipersSucceed
		testFetchVipersFail

	4. VPRouterTest class has the following tests:

		testRouterGenerateAllElements
		
	5. VPViewControllerTest class creates mock VPPresenter with the following tests:

		testInitialState
		testFetchVipersFail
		testFetchVipersSucceed
		testFetchVipersNoContents
		testLoadingStateUI
		testLoadedStateUI
		testNoDataStateUI
		testErrorStateUI

	6. VPLoadingViewTest has the following tests

		testShow
		testHide

	7. VPMsgViewTest has the following tests

		testShow
		testHide

	8. VPImageViewTest class creates mock ImageCacheManager and MockDownloadManager with the following tests:

		testImageDownloadSucceed
		testImageDownloadError
		testImageDidCache
		testImageDownloadCancel
		testGetImageFromCache
		testGetImageWithEmptyURL

	9. VPVipersDataSourceTest creates mock VPViewModel with the following tests:

		testNumberOfRows
		testTableViewCellData

	10. VPViewModelTest has the following tests:

		testGetOverviewTitleHasData
		testGetOverviewTitleHasNoData
		testHasVipersData
		testHasNoVipersData
		testVipersCount
		testGetCellViewModelSucceed
		testGetCellViewModelFail

	11. VPCellViewModelTest has the following tests:

		testHasImageURL
		testHasNoImageURL
		testHasLevel
		testHasNoLevel
		testHasIsAccessible
		testHasNoAccessible



