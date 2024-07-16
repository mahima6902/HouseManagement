using { app.house_management as hm } from '../db/house_mgt';

service HouseManagementService {
  entity groceries as projection on hm.grocery;
  entity workers as projection on hm.worker;
  entity monthlyexpenditures as projection on hm.monthlyexpenditure;
  entity utilities as projection on hm.utility;
  entity maintenancetasks as projection on hm.maintenance;
}