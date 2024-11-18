import { BusinessError, Callback } from '@kit.BasicServicesKit'
import { ListMember, ListMemberDataSource } from "../DataModel/DataInfo"
import { router } from '@kit.ArkUI'
import { rdbStore } from "../entryability/EntryAbility"
import rs from '@ohos.data.relationalStore'

@Entry
@Component
struct Index {
  @State ListCt: ListMemberDataSource = new ListMemberDataSource()
  @State letters: string[] = ['※', 'A','B','C','D','E','F','H','I','G','K','L','M','N', 'O','P','Q','R','S','T','U','V','W','X','Y','Z','#']
  @State ListArray: Array<ListMember> = []
  private listScroller: Scroller = new Scroller();
  @State selectedIndex: number = 0;

  queryContactsListData() {
    let predicates: rs.RdbPredicates = new rs.RdbPredicates("AddressTable");

    if(rdbStore){
      rdbStore.query(predicates, ["id", 'name', 'mobile', 'img'], (err, resultSet) => {
        if (err) {
          console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`ResultSet column names: ${resultSet.columnNames}, row count: ${resultSet.rowCount}`)
        if(resultSet.rowCount == -1){
          console.info("rowCount = -1")
        }

        while (resultSet.goToNextRow()) {
          const id: number = resultSet.getLong(resultSet.getColumnIndex("ID"))
          const name: string = resultSet.getString(resultSet.getColumnIndex("name"))
          const mobile: string = resultSet.getString(resultSet.getColumnIndex("mobile"))
          const img: string = resultSet.getString(resultSet.getColumnIndex("img"));
          console.info(`id=${id}, name=${name}, mobile=${mobile}, img=${img}`)

          this.ListArray.push(new ListMember(id, name, mobile, img))
        }
        // 释放数据集的内存
        resultSet.close();
      })
    }else{
      console.log("Failed to query data. The RdbStore isn't exist.")
    }

  }

  onPageShow(): void {
    this.queryContactsListData()
    this.ListCt.SetArr(this.ListArray)
  }

  build() {
    Column() {
      Text('通讯录').width('100%').padding({ left: 16, top: 20 }).fontSize(20).fontWeight(500)
      RelativeContainer() {
        Stack({ alignContent: Alignment.End }) {
          Column() {
            List({ scroller: this.listScroller }) {
              ForEach(this.ListArray,(item: ListMember, index: number) => {
                ListItem() {
                  Text(item.name).fontSize(100)
                }
              })
            }
          }

          AlphabetIndexer({ arrayValue: this.letters, selected: 0 })
            .color(Color.Black)
            .selectedColor(0xFFFFFF)
            .popupColor(0xFFFAF0)
            .selectedBackgroundColor('rgb(1,196,194)')
            .popupBackground(0xD2B48C)
            .usingPopup(true)
            .selectedFont({ size: 13, weight: FontWeight.Bolder })
            .popupFont({ size: 30, weight: FontWeight.Bolder })
            .itemSize(25)
            .alignStyle(IndexerAlign.Left)// 弹出框在索引条左侧弹出
            .onSelect((index: number) => {
              console.info(this.letters[index] + ' Selected!', index)
              this.listScroller.scrollToIndex(index)
            })
            .onPopupSelect((index: number) => {
              console.info('onPopupSelected:' + index)
            })
            .selected(this.selectedIndex)
        }

          Image($r('app.media.img_add'))
            .width(58)
            .fillColor('#44bf02')
            .alignRules({
              bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
              right: { anchor: '__container__', align: HorizontalAlign.End }
            })
            .margin({ right: 30, bottom: 60 })
            .onClick(() => {
              router.pushUrl({
                url: "pages/CreatePage"
              })
                .catch((err: BusinessError) => {
                console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
              })
            })

      }

    }
  }
}

