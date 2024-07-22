sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'app/housemanagement/housemgtapp/test/integration/FirstJourney',
		'app/housemanagement/housemgtapp/test/integration/pages/workersList',
		'app/housemanagement/housemgtapp/test/integration/pages/workersObjectPage',
		'app/housemanagement/housemgtapp/test/integration/pages/maintenancetasksObjectPage'
    ],
    function(JourneyRunner, opaJourney, workersList, workersObjectPage, maintenancetasksObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('app/housemanagement/housemgtapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheworkersList: workersList,
					onTheworkersObjectPage: workersObjectPage,
					onThemaintenancetasksObjectPage: maintenancetasksObjectPage
                }
            },
            opaJourney.run
        );
    }
);