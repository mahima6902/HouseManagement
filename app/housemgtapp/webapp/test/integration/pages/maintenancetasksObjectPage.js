sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'app.housemanagement.housemgtapp',
            componentId: 'maintenancetasksObjectPage',
            contextPath: '/workers/tasks'
        },
        CustomPageDefinitions
    );
});