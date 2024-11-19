import { promptAction, router } from '@kit.ArkUI';
import rdb from "../pages/UserDBUtils";

const colors: Array<string> = ['#ff6161', '#ffb120', '#7484fc', '#00cee5']

function getRandomColor():string {
  const randomIndex = Math.floor(Math.random() * colors.length);
  return colors[randomIndex];
}

@Entry
@Component
struct CreateContactsPage {
  @State get_params: object | undefined = undefined
  @State input_name: string = ""
  @State input_mobile: string = ""
  @State now_id: number = 0
  aboutToAppear(): void {
    this.get_params = router.getParams()
    const name: string = this.get_params['name'];
    this.input_name = name
    const mobile: string = this.get_params['mobile'];
    this.input_mobile = mobile
    const id: number = this.get_params['id'];
    this.now_id = id
    console.log(`Received parameters: id = ${name}, age = ${mobile}`);
  }

  build() {

    Column() {
      Row() {
        Image($r('app.media.img_back')).width(24)
        Text('编辑联系人')
          .padding({ left: 16 })
          .fontSize(18)
          .fontWeight(500)
      }
      .width('100%')
      .padding({ left: 16 })
      .onClick(() => {
        router.pushUrl({
          url: 'pages/Index'
        })
      })


      Column() {
        TextInput({ placeholder: this.input_name})
          .copyOption(CopyOptions.LocalDevice)
          .onChange((value) => {
            this.input_name = value
          })

        TextInput({ placeholder: this.input_mobile })
          .type(InputType.PhoneNumber)
          .margin({ top: 10 })
          .onChange((value) => {
            this.input_mobile = value
          })

        Button('修改联系人')
          .width('100%')
          .fontColor("#FFFFFF")
          .margin({ top: 30 })
          .onClick(() => {
            if (this.input_name == '' || this.input_mobile == '') {
              promptAction.showToast({
                message: '联系人姓名或手机号不能为空'
              })

              return
            }

            if (rdb.getInstance()!== undefined) {
              rdb.getInstance().UpdateData(this.input_name, this.input_mobile, "", this.now_id)
                promptAction.showToast({
                  message: '修改成功'
                })
                router.replaceUrl({
                  url: 'pages/Index',
                  params: {
                    result_code: 200
                  }
                })
              } else {
              console.error('------------', `Failed store is undefined`);
            }

          })

        Button('删除联系人')
          .width('100%')
          .margin({ top: 10 })
          .backgroundColor("#ffd03f3f")
          .fontColor("#FFFFFF")
          .onClick(() => {

            if (rdb.getInstance()!== undefined) {
              rdb.getInstance().DeleteData(this.now_id as number)
              promptAction.showToast({
                message: '删除成功'
              })
              router.replaceUrl({
                url: 'pages/Index',
                params: {
                  result_code: 200
                }
              })
            } else {
              console.error('------------', `Failed store is undefined`);
            }

          })

      }.alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(20)
      .margin({ top: 50 })

    }
    .height('100%')
    .width('100%')
  }
}
