class TimeModel {
  dynamic key;
  dynamic value;
  TimeModel({this.key, this.value});
}

List<TimeModel> timeData = [
  TimeModel(
    key: "this_week",
    value: "This Week",
  ),
  TimeModel(
    key: "last_week",
    value: "Last Week",
  ),
  TimeModel(
    key: "this_month",
    value: "This Month",
  ),
  TimeModel(
    key: "last_month",
    value: "Last Month",
  ),
  TimeModel(
    key: "custom",
    value: "Custom calender",
  ),
];

class Status {
  dynamic key;
  dynamic value;
  Status({this.key, this.value});
}

List<Status> status = [
  Status(
    key: "OP",
    value: "Order Placed",
  ),
  Status(
    key: "A",
    value: "Accepted",
  ),
  Status(
    key: "R",
    value: "Reject",
  ),
  Status(
    key: "PC",
    value: "Pickup",
  ),
  Status(
    key: "RR",
    value: "Return Request",
  ),
  Status(
    key: "RF",
    value: "Refund",
  ),
  Status(
    key: "D",
    value: "Delivered",
  ),
];
