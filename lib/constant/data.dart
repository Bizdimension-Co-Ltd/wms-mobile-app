String getObjectTable(dynamic code) {
  switch (code) {
    case 17:
      return '/Orders';
    case 1250000001:
      return '/InventoryTransferRequests';
    case 202:
      return '/ProductionOrders';
    default:
      return '';
  }
}
