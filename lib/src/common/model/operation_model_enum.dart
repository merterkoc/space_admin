enum OperationType {
  add,
  edit,
  delete;

  bool get isAdd => this == OperationType.add;

  bool get isEdit => this == OperationType.edit;

  bool get isDelete => this == OperationType.delete;
}
