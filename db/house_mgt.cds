namespace app.house_management;
using {cuid, managed} from '@sap/cds/common';

entity grocery {
  key id : UUID;
  name : String;
  quantity : Integer;
  unit : String;
  price : Decimal;
  purchasedate : Date;
  monthlyexpenditure : Association to monthlyexpenditure;
}

entity worker {
  key id : UUID;
  name : String;
  role : String;
  hourlyrate : Decimal;
  hoursworked : Decimal;
  paymentdue : Decimal;
  tasks : Association to many maintenance on tasks.worker = $self;
}

entity monthlyexpenditure {
  key id : UUID;
  month : Integer;
  year : Integer;
  groceryexpense : Decimal;
  workerexpense : Decimal;
  utilityexpense : Decimal;
  totalexpense : Decimal;
  groceries : Association to many grocery on groceries.monthlyexpenditure = $self;
  utilities : Association to many utility on utilities.monthlyexpenditure = $self;
}

entity utility {
  key id : UUID;
  name : String;
  amount : Decimal;
  duedate : Date;
  paid : Boolean;
  monthlyexpenditure : Association to monthlyexpenditure;
}

entity maintenance {
  key id : UUID;
  description : String;
  cost : Decimal;
  date : Date;
  status : String enum {
        pending;
        inprogress;
        completed;
  };
  worker : Association to worker;
}

