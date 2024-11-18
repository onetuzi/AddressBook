import { promptAction, router } from '@kit.ArkUI';
import { relationalStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { rdbStore } from '../entryability/EntryAbility';


const colors: Array<string> = ['#ff6161', '#ffb120', '#7484fc', '#00cee5']

function getRandomColor():string {
  const randomIndex = Math.floor(Math.random() * colors.length);
  return colors[randomIndex];
}

@Entry
@Component
struct CreateContactsPage {
  @State input_name: string = ''
  @State input_mobile: string = ''

  build() {

    Column() {
      Row() {
        Image($r('app.media.img_back')).width(24)
        Text('新建联系人')
          .padding({ left: 16 })
          .fontSize(18)
          .fontWeight(500)
      }
      .width('100%')
      .padding({ left: 16 })
      .onClick(() => {
        router.back()
      })


      Column() {
        TextInput({ placeholder: '请输入联系人姓名'})
          .copyOption(CopyOptions.LocalDevice)
          .onChange((value) => {
            this.input_name = value
          })

        TextInput({ placeholder: '请输入手机号' })
          .type(InputType.PhoneNumber)
          .margin({ top: 10 })
          .onChange((value) => {
            this.input_mobile = value
          })

        Button('新建联系人')
          .width('100%')
          .margin({ top: 30 })
          .onClick(() => {
            if (this.input_name == '' || this.input_mobile == '') {
              promptAction.showToast({
                message: '联系人姓名或手机号不能为空'
              })

              return
            }

            if (rdbStore !== undefined) {
              const valuesBucket: relationalStore.ValuesBucket = {
                'name': this.input_name,
                'mobile': this.input_mobile,
              }
              rdbStore.insert('AddressTable', valuesBucket, (err: BusinessError, rowId: number) => {
                if (err) {
                  console.error(`------------Failed to insert data. Code:${err.code}, message:${err.message}`);
                  return
                }
                promptAction.showToast({
                  message: '创建成功'
                })

                router.back({
                  url: 'pages/Index',
                  params: {
                    result_code: 200
                  }
                })
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
