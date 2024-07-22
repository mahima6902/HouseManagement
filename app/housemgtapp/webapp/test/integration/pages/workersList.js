sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'app.housemanagement.housemgtapp',
            componentId: 'workersList',
            contextPath: '/workers'
        },
        CustomPageDefinitions
    );
});