import rs from '@ohos.data.relationalStore'
import { BusinessError, Callback } from '@kit.BasicServicesKit'
import { ValuesBucket } from '@kit.ArkData'
import { ListMember } from '../DataModel/DataInfo'
import common from '@ohos.app.ability.common'

export default class rdb{
  private rdbStore: rs.RdbStore | undefined = undefined
  private static rdbInstance: rdb | undefined = undefined
  context?: Context = getContext()

  public static getInstance(): rdb{
    if(!rdb.rdbInstance) rdb.rdbInstance = new rdb()
    return rdb.rdbInstance
  }

  async InitDb(context: common.Context): Promise<void> {

    if(this.rdbStore){
      return
    }

    const DbConfig: rs.StoreConfig = {
      name: "AddressBookDB",
      securityLevel: rs.SecurityLevel.S1
    }

    try{
      this.rdbStore = await rs.getRdbStore(context, DbConfig) as (rs.RdbStore | undefined)
      await this.CreateTable()
    } catch (err){
      console.error(`Error! Code:${err.code}, message:${err.message}`);
    }


  }

  async CreateTable(){
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

  async InsertData(name: string, mobile: string, img: string): Promise<void>{
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
          return
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

  async RequestData(): Promise<Array<ListMember>> {
    // 配置谓词
    let predicates: rs.RdbPredicates = new rs.RdbPredicates("AddressTable");
    let Data: Array<ListMember> = new Array<ListMember>();

    if (this.rdbStore) {
      // 将异步操作包装在 Promise 中
      Data = await new Promise<Array<ListMember>>((resolve, reject) => {
        (this.rdbStore as rs.RdbStore).query(predicates, ["id", "name", "mobile", "img"], (err, resultSet) => {
          if (err) {
            console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
            reject(err); // 处理错误
            return;
          }
          console.info(`ResultSet column names: ${resultSet.columnNames}, row count: ${resultSet.rowCount}`);
          if (resultSet.rowCount == -1) {
            console.info("rowCount = -1");
          }

          while (resultSet.goToNextRow()) {
            const id = resultSet.getLong(resultSet.getColumnIndex("ID"));
            const name = resultSet.getString(resultSet.getColumnIndex("name"));
            const mobile = resultSet.getString(resultSet.getColumnIndex("mobile"));
            const img = resultSet.getString(resultSet.getColumnIndex("img"));
            console.info(`id=${id}, name=${name}, mobile=${mobile}, img=${img}`);

            const value: ListMember = new ListMember(id, name, mobile, img);
            Data.push(value);
          }
          // 释放数据集的内存
          resultSet.close();
          console.info("JSON: " + JSON.stringify(Data));
          resolve(Data); // 返回数据
        });
      });
    }

    return Data;
  }

}

export let dbControllor: rdb = new rdb()