public with sharing class OrdersAndProductsController {
    public List<Order> showOrders{get; private set;}

    public OrdersAndProductsController() {
        System.debug('OrdersAndProductsController Constructor is Here');
        this.showOrders = [SELECT Id, orderNumber, totalAmount, status FROM Order];
    }

    public void deleteOrder(){
        String orderId = apexpages.currentpage().getParameters().get('orderId');
        Order o = [SELECT Id FROM Order WHERE Id=:orderId];
        delete o;
        this.showOrders = [SELECT Id, orderNumber, totalAmount, status FROM Order];
    }
}