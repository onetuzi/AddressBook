import { pinyin } from "pinyin-pro"

export class ListMember{
  id: number
  name: string
  mobile: string
  img: string

  constructor(id: number, name: string, mobile: string, img: string) {
    this.id = id
    this.name = name
    this.mobile = mobile
    this.img = img
  }
}

class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];
  private originDataArray: object[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): object {
    return this.originDataArray[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }


  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }

}

export class ListMemberDataSource extends BasicDataSource {
  private dataArray: Array<Contacts> = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): Contacts {
    return this.dataArray[index];
  }

  public addData(index: number, data: Contacts): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: Contacts): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  // 数据直接重新赋值
  public reloadData(data: Array<Contacts>) {
    this.dataArray = data
    this.notifyDataReload()
  }

  public SetArr(data: Array<ListMember>){
    this.dataArray = []

    // 处理拼音
    for(let i = 0; i < data.length; i++) {
      let pinyinStr = pinyin(data[i].name, { toneType: "none" }) as string
      let index = pinyinStr.substring(0, 1).toUpperCase();
      if (!/^[A-Z]$/.test(index)) { // 如果不在A-Z中则默认为“#”
        index = "#";
      }
      console.log(data[i].name + " " + index);
      this.dataArray.push(new Contacts(index, new ListMember(data[i].id, data[i].name, data[i].mobile, data[i].img)))
    }
    // 排序

    this.dataArray.sort((a:Contacts, b: Contacts) => {
      if (a.index === b.index) {
        return a.data.name.localeCompare(b.data.name) as number
      }
      if (a.index === "#") {
        return 1
      }
      if (b.index === "#") {
        return -1
      }
      return a.index.localeCompare(b.index)
    })

    this.notifyDataReload()
  }

}

export class Contacts {
  constructor(index: string, data: ListMember) {
    this.index = index
    this.data = data
  }
  index: string // 序号
  data: ListMember
}