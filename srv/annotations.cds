using HouseManagementService as service from './house_srv';


//tableA - Groceries
annotate service.groceries with @(UI: {
    CreateHidden : false,
    UpdateHidden : false,
    DeleteHidden : false,
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
        {
            Value: name,
            Label: 'Name'
        },
        {
            Value: quantity,
            Label: 'Quantity'
        },
        {
            Value: unit,
            Label: 'Unit'
        },
        {
            Value: price,
            Label: 'Price'
        },
        {
            Value: purchasedate,
            Label: 'Purchase Date'
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
            Value: name,
            Label: 'Name'
        },
        {
            Value: quantity,
            Label: 'Quantity'
        },
        {
            Value: unit,
            Label: 'Unit'
        },
        {
            Value: price,
            Label: 'Price'
        },
        {
            Value: purchasedate,
            Label: 'Purchase Date'
        },
        {
            Value: monthlyexpenditure_id,
            Label: 'Monthly Expenditure ID'
        }
    ]}
});


//tableB - Workers
annotate service.workers with @(UI: {
    CreateHidden : false,
    UpdateHidden : false,
    DeleteHidden : false,
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
        {
            Value: name,
            Label: 'Name'
        },
        {
            Value: role,
            Label: 'Role'
        },
        {
            Value: hourlyrate,
            Label: 'Hourly Rate'
        },
        {
            Value: hoursworked,
            Label: 'Hours Worked'
        },
        {
            Value: paymentdue,
            Label: 'Payment Due'
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
            Value: name,
            Label: 'Name'
        },
        {
            Value: role,
            Label: 'Role'
        },
        {
            Value: hourlyrate,
            Label: 'Hourly Rate'
        },
        {
            Value: hoursworked,
            Label: 'Hours Worked'
        },
        {
            Value: paymentdue,
            Label: 'Payment Due'
        }
    ]}
});


//tableC - Monthly Expenditures
annotate service.monthlyexpenditures with @(UI: {
    CreateHidden : false,
    UpdateHidden : false,
    DeleteHidden : false,
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
        {
            Value: month,
            Label: 'Month'
        },
        {
            Value: year,
            Label: 'Year'
        },
        {
            Value: groceryexpense,
            Label: 'Grocery Expense'
        },
        {
            Value: workerexpense,
            Label: 'Worker Expense'
        },
        {
            Value: utilityexpense,
            Label: 'Utility Expense'
        },
        {
            Value: totalexpense,
            Label: 'Total Expense'
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
        {
            Value: month,
            Label: 'Month'
        },
        {
            Value: year,
            Label: 'Year'
        },
        {
            Value: groceryexpense,
            Label: 'Grocery Expense'
        },
        {
            Value: workerexpense,
            Label: 'Worker Expense'
        },
        {
            Value: utilityexpense,
            Label: 'Utility Expense'
        },
        {
            Value: totalexpense,
            Label: 'Total Expense'
        }
    ]}
});


//tableD - Utilities
annotate service.utilities with @(UI: {
    CreateHidden : false,
    UpdateHidden : false,
    DeleteHidden : false,
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
            Value: name,
            Label: 'Name'
        },
        {
            Value: amount,
            Label: 'Amount'
        },
        {
            Value: duedate,
            Label: 'Due Date'
        },
        {
            Value: paid,
            Label: 'Paid'
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
            Value: name,
            Label: 'Name'
        },
        {
            Value: amount,
            Label: 'Amount'
        },
        {
            Value: duedate,
            Label: 'Due Date'
        },
        {
            Value: paid,
            Label: 'Paid'
        },
        {
            Value: monthlyexpenditure_id,
            Label: 'Monthly expenditure ID'
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
