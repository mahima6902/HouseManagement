using HouseManagementService as service from './house_srv';

//tableA - Groceries
annotate service.groceries with @(UI: {
    HeaderInfo         : {
        TypeName      : 'Grocery',
        TypeNamePlural: 'Groceries',
        Title         : {Value: name}
    },
    SelectionFields    : [
        name,
        purchasedate
    ],
    LineItem           : [
        {Value: name},
        {Value: quantity},
        {Value: unit},
        {Value: price},
        {Value: purchasedate}
    ],
    Facets             : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Details',
        Target: '@UI.FieldGroup#Details'
    }],
    FieldGroup #Details: {Data: [
        {Value: name},
        {Value: quantity},
        {Value: unit},
        {Value: price},
        {Value: purchasedate},
        {Value: monthlyexpenditure_id}
    ]}
});


//tableB - Workers
annotate service.workers with @(UI: {
    HeaderInfo         : {
        TypeName      : 'Worker',
        TypeNamePlural: 'Workers',
        Title         : {Value: name}
    },
    SelectionFields    : [
        name,
        role
    ],
    LineItem           : [
        {Value: name},
        {Value: role},
        {Value: hourlyrate},
        {Value: hoursworked},
        {Value: paymentdue}
    ],
    Facets             : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Details',
        Target: '@UI.FieldGroup#Details'
    }],
    FieldGroup #Details: {Data: [
        {Value: name},
        {Value: role},
        {Value: hourlyrate},
        {Value: hoursworked},
        {Value: paymentdue}
    ]}
});


//tableC - Monthly Expenditures
annotate service.monthlyexpenditures with @(UI: {
    HeaderInfo         : {
        TypeName      : 'Monthly Expenditure',
        TypeNamePlural: 'Monthly Expenditures',
        Title         : {Value: month}
    },
    SelectionFields    : [
        month,
        year
    ],
    LineItem           : [
        {Value: month},
        {Value: year},
        {Value: groceryexpense},
        {Value: workerexpense},
        {Value: utilityexpense},
        {Value: totalexpense}
    ],
    Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Groceries',
            Target: 'groceries/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Utilities',
            Target: 'utilities/@UI.LineItem'
        }
    ],
    FieldGroup #Details: {Data: [
        {Value: month},
        {Value: year},
        {Value: groceryexpense},
        {Value: workerexpense},
        {Value: utilityexpense},
        {Value: totalexpense}
    ]}
});


//tableD - Utilities
annotate service.utilities with @(UI: {
    HeaderInfo         : {
        TypeName      : 'Utility',
        TypeNamePlural: 'Utilities',
        Title         : {Value: name}
    },

    SelectionFields    : [
        name,
        duedate,
        paid
    ],

    LineItem           : [
        {
            Value: name
        },
        {
            Value: amount
        },
        {
            Value: duedate
        },
        {
            Value: paid
        }
    ],

    Facets             : [
        {
        $Type : 'UI.ReferenceFacet',
        Label : 'Details',
        Target: '@UI.FieldGroup#Details'
        }
    ],

    FieldGroup #Details: {Data: [
        {
            Value: name
        },
        {
            Value: amount
        },
        {
            Value: duedate
        },
        {
            Value: paid
        },
        {
            Value: monthlyexpenditure_id
        }
    ]}
});


//tableE - Maintenance Tasks
annotate service.maintenancetasks with @(UI: {
    HeaderInfo         : {
        TypeName      : 'Maintenance Task',
        TypeNamePlural: 'Maintenance Tasks',
        Title         : {Value: description}
    },

    SelectionFields    : [
        description,
        status,
        date
    ],

    LineItem           : [
        {
            Value: description,
            Label : 'Description'
        },
        {
            Value: cost,
            Label : 'Cost'
        },
        {
            Value: date,
            Label : 'Date'
        },
        {
            Value: status,
            Label : 'Status'
        },
        {
            Value: worker.name,
            Label: 'Assigned Worker'
        }
    ],

    Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Worker',
            Target: 'worker/@UI.FieldGroup#Details'
        }
    ],
    
    FieldGroup #Details: {Data: [
        {
            Value: description,
            Label : 'Description'
        },
        {
            Value: cost,
            Label : 'Cost'
        },
        {
            Value: date,
            Label : 'Date'
        },
        {
            Value: status,
            Label : 'Status'
        },
        {
            Value: worker_id,
            Label : 'Worker ID'
        }
    ]}
});
