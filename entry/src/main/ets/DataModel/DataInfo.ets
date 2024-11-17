
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
  private dataArray: Array<ListMember> = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): ListMember {
    return this.dataArray[index];
  }

  public addData(index: number, data: ListMember): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: ListMember): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  // 数据直接重新赋值
  public reloadData(data: ListMember[]) {
    this.dataArray = data
    this.notifyDataReload()
  }
}
