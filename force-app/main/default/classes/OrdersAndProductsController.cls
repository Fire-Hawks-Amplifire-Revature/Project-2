public with sharing class OrdersAndProductsController {
    public List<Order> showOrders{get; private set;}

    public OrdersAndProductsController() {
        System.debug('OrdersAndProductsController Constructor is Here');
        this.showOrders = [SELECT Id, orderNumber, totalAmount, status FROM Order WHERE pricebook2Id != null WITH USER_MODE];
    }

    public void deleteOrder(){
        String orderId = apexpages.currentpage().getParameters().get('orderId');
        Order o = [SELECT Id FROM Order WHERE Id=:orderId WITH USER_MODE];
        delete o;
        this.showOrders = [SELECT Id, orderNumber, totalAmount, status FROM Order WHERE pricebook2Id != null WITH USER_MODE];
    }
}