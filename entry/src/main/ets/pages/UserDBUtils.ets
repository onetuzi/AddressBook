import rs from '@ohos.data.relationalStore'
import { BusinessError, Callback } from '@kit.BasicServicesKit'
import { ValuesBucket } from '@kit.ArkData'
import { ListMember } from '../DataModel/DataInfo'

export default class rdb{
  rdbStore?: rs.RdbStore
  context?: Context = getContext()

  constructor() {
    const DbConfig: rs.StoreConfig = {
      name: "AddressBookDB",
      securityLevel: rs.SecurityLevel.S1
    }

    rs.getRdbStore(this.context, DbConfig, (err: BusinessError, rdbStore: rs.RdbStore) => {
      this.rdbStore = rdbStore;
      if (err) {
        console.error(`Get RdbStore failed, code is ${err.code},message is ${err.message}`);
        return;
      }
      console.info(`Get RdbStore successfully.`);
    })
  }

  CreateTable(){
    const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS AddressTable (' +
      'id INTEGER PRIMARY KEY AUTOINCREMENT,' +
      'name TEXT,' +
      'mobile TEXT,' +
      'img TEXT)';

    if(this.rdbStore){
      this.rdbStore.executeSql(SQL_CREATE_TABLE);
      console.info(`CreateTable successfully.`);
    }
  }

  InsertData(name: string, mobile: string, img: string) {
    // 插入数据
    const valueBucket: ValuesBucket = {
      'name': name,
      'mobile': mobile,
      'img': img
    };

    if(this.rdbStore){
      this.rdbStore.insert('AddressTable', valueBucket, (err, rowId) => {
        if (err) {
          console.error(`Failed to insert data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`Succeeded in inserting data. rowId:${rowId}`);
      })
    }
  }

  DeleteData(DelID: number) {
    let predicates: rs.RdbPredicates = new rs.RdbPredicates("AddressTable");
    predicates.equalTo("id", DelID);
    if(this.rdbStore != undefined) {
      (this.rdbStore as rs.RdbStore).delete(predicates, (err, rows) => {
        if (err) {
          console.error(`Delete failed, code is ${err.code},message is ${err.message}`);
          return;
        }
        console.info(`Delete rows: ${rows}`);
      })
    }
  }

  UpdateData(name: string, mobile: string, img: string, ChangeID: number) {
    const valueBucket: ValuesBucket = {
      'name': name,
      'mobile': mobile,
      'img': img
    };

    let predicates: rs.RdbPredicates = new rs.RdbPredicates("AddressTable");
    predicates.equalTo("id", ChangeID);
    if(this.rdbStore != undefined) {
      (this.rdbStore as rs.RdbStore).update(valueBucket, predicates, rs.ConflictResolution.ON_CONFLICT_REPLACE, (err, rows) => {
        if (err) {
          console.error(`Updated failed, code is ${err.code},message is ${err.message}`);
          return;
        }
        console.info(`Updated row count: ${rows}`);
      })
    }
  }

  RequestData(): Array<ListMember> {
    // 配置谓词
    let predicates: rs.RdbPredicates = new rs.RdbPredicates("AddressTable");
    let jsonData: Array<ListMember> = new Array<ListMember>();

    if(this.rdbStore){
      this.rdbStore.query(predicates, ["id", 'name', 'mobile', 'img'], (err, resultSet) => {
        if (err) {
          console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`ResultSet column names: ${resultSet.columnNames}, row count: ${resultSet.rowCount}`);
        if(resultSet.rowCount == -1){
          console.info("rowCount = -1")
        }

        while (resultSet.goToNextRow()) {
          const id = resultSet.getLong(resultSet.getColumnIndex("ID"));
          const name = resultSet.getString(resultSet.getColumnIndex("name"));
          const mobile = resultSet.getString(resultSet.getColumnIndex("mobile"));
          const img = resultSet.getString(resultSet.getColumnIndex("img"));
          console.info(`id=${id}, name=${name}, mobile=${mobile}, img=${img}`);

          const value: ListMember = new ListMember(id, name, mobile, img);
          jsonData.push(value)
        }
        // 释放数据集的内存
        resultSet.close();
        // console.info("JSON: " + JSON.stringify(jsonData))
      })
    }
    return jsonData
  }

}