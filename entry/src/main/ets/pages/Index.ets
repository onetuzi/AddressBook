import rdb from "./UserDBUtils"
import { ListMember, ListMemberDataSource } from "../DataModel/DataInfo"

let dbController: rdb = new rdb()

@Entry
@Component
struct Index {
  @State ListCt: ListMemberDataSource = new ListMemberDataSource()
  @State letters: string[] = ['→', '※', 'A','B','C','D','E','F','H','I','G','K','L','M','N', 'O','P','Q','R','S','T','U','V','W','X','Y','Z','#']
  private listScroller: Scroller = new Scroller();
  @State selectedIndex: number = 0;
  aboutToAppear(): void {
    dbController.CreateTable()
    dbController.InsertData("a","b","")
    dbController.RequestData()
  }

  build() {
    Column() {
      Text('通讯录').width('100%').padding({ left: 16, top: 20 }).fontSize(20).fontWeight(500)
      Stack({ alignContent: Alignment.End }) {
        Column() {
          List() {
            LazyForEach(this.ListCt, (item: ListMember, index: number) => {
              ListItem() {

                Scroll() {
                  Column() {
                    if (item.img == "") {
                      Text(item.name.substring(0, 1))
                        .width(44)
                        .height(44)
                        .borderRadius(22)
                        .backgroundColor("#FFFFFFF")
                        .fontColor('#FFFFFFF')
                        .textAlign(TextAlign.Center)
                        .fontSize(20)
                        .fontWeight(600)
                    } else {
                      Image(item.img)
                    }

                    Column() {
                      Text(item.name)
                      Text(item.mobile).fontColor('#999999').fontSize(14).margin({ top: 6 })

                    }
                    .alignItems(HorizontalAlign.Start)

                  }
                }
              }
            })
          }
        }

        AlphabetIndexer({ arrayValue: this.letters, selected: 0 })
          .color(Color.Black)
          .selectedColor(0xFFFFFF) // 选中项文本颜色
          .popupColor(0xFFFAF0) // 弹出框文本颜色
          .selectedBackgroundColor('rgb(1,196,194)') // 选中项背景颜色
          .popupBackground(0xD2B48C) // 弹出框背景颜色
          .usingPopup(true) // 是否显示弹出框
          .selectedFont({ size: 13, weight: FontWeight.Bolder }) // 选中项字体样式
          .popupFont({ size: 30, weight: FontWeight.Bolder }) // 弹出框内容的字体样式
          .itemSize(20) // 每一项的尺寸大小
          .alignStyle(IndexerAlign.Left) // 弹出框在索引条左侧弹出
          .onSelect((index: number) => {
            console.info(this.letters[index] + ' Selected!', index)
            this.listScroller.scrollToIndex(index)
          })
          .onPopupSelect((index: number) => {
            console.info('onPopupSelected:' + index)
          })
          .selected(this.selectedIndex)

      }
    }

  }
}

