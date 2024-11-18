import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import rs from '@ohos.data.relationalStore'
export let rdbStore: rs.RdbStore | undefined = undefined;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 新建数据库
    const DbConfig: rs.StoreConfig = {
      name: "AddressBookDB",
      securityLevel: rs.SecurityLevel.S1
    }

    rs.getRdbStore(this.context, DbConfig, (err, rdbStore_ret: rs.RdbStore) => {
      if (err) {
        console.error(`Get RdbStore failed, code is ${err.code},message is ${err.message}`);
        return;
      }
      rdbStore = rdbStore_ret;

      // 新建数据表
      const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS AddressTable (' +
        'id INTEGER PRIMARY KEY AUTOINCREMENT,' +
        'name TEXT,' +
        'mobile TEXT,' +
        'img TEXT)';

      rdbStore.executeSql(SQL_CREATE_TABLE);
      console.info(`CreateTable successfully.`);

    })

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
