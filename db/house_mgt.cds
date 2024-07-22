namespace app.house_management;
using {cuid, managed} from '@sap/cds/common';


//tableA - GROCERY
entity grocery {
  @title : 'ID'
  key id : UUID;

  @title : 'Name of item'
  name : String;

  @title : 'Quantity'
  quantity : Integer;

  @title : 'Unit'
  unit : String;

  @title : 'Price'
  price : Decimal;

  @title : 'Date of Purchase'
  purchasedate : Date;

  @title : 'Monthly Expenditure'
  monthlyexpenditure : Association to monthlyexpenditure;
}

//tableB - WORKERS
entity worker {
  @title : 'ID'
  key id : UUID;

  @title : 'Name'
  name : String;

  @title : 'Role'
  role : String;

  @title : 'Hourly Rate'
  hourlyrate : Decimal;

  @title : 'Hours Worked'
  hoursworked : Decimal;

  @title : 'Payment Due'
  paymentdue : Decimal;

  @title : 'Tasks'
  tasks : Association to many maintenance on tasks.worker = $self;
}

//tableC - MONTHLY EXPENDITURE
entity monthlyexpenditure {
  @title : 'ID'
  key id : UUID;

  @title : 'Month'
  month : Integer;

  @title : 'Year'
  year : Integer;

  @title : 'Grocery Expense'
  groceryexpense : Decimal;

  @title : 'Worker Expense'
  workerexpense : Decimal;

  @title : 'Utility Expense'
  utilityexpense : Decimal;

  @title : 'Total Expense'
  totalexpense : Decimal;

  @title : 'Groceries'
  groceries : Association to many grocery on groceries.monthlyexpenditure = $self;

  @title : 'Utilities'
  utilities : Association to many utility on utilities.monthlyexpenditure = $self;
}

//tableD - UTILITY
entity utility {
  @title : 'ID'
  key id : UUID;

  @title : 'Name'
  name : String;

  @title : 'Amount'
  amount : Decimal;

  @title : 'Due Date'
  duedate : Date;

  @title : 'Paid'
  paid : Boolean;

  @title : 'Monthly Expenditure'
  monthlyexpenditure : Association to monthlyexpenditure;
}

//tableE - MAINTENANCE
entity maintenance {
  @title : 'ID'
  key id : UUID;

  @title : 'Description'
  description : String;

  @title : 'Cost'
  cost : Decimal;

  @title : 'Date'
  date : Date;

  @title : 'Status'
  status : String enum {
        pending;
        inprogress;
        completed;
  };

  @title : 'Worker'
  worker : Association to worker;
}
