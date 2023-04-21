public with sharing class OrdersAndProductsController {
    public List<Order> showOrders{get; private set;}

    public OrdersAndProductsController() {
        System.debug('OrdersAndProductsController Constructor is Here');
        this.showOrders = [SELECT Id, orderNumber, totalAmount, status FROM Order WHERE pricebook2Id != null WITH USER_MODE];
    }

    public PageReference deleteOrder(){
        String orderId = apexpages.currentpage().getParameters().get('orderId');
        Order o = new Order();
        try{
            o = [SELECT Id, OrderNumber FROM Order WHERE Id=:orderId WITH USER_MODE];
        } catch(System.QueryException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, 'There are currently no orders for you to view.'));
            this.showOrders = [SELECT Id, orderNumber, totalAmount, status FROM Order WHERE pricebook2Id != null WITH USER_MODE];
            return Page.Orders_and_Products;
        }

        if(o.orderNumber != null){
            try{
                delete o;
            } catch(System.DmlException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, 'This Order has already been deleted. Be careful not to double-click delete.'));
                this.showOrders = [SELECT Id, orderNumber, totalAmount, status FROM Order WHERE pricebook2Id != null WITH USER_MODE];
                return Page.Orders_and_Products;
            }
        }

        this.showOrders = [SELECT Id, orderNumber, totalAmount, status FROM Order WHERE pricebook2Id != null WITH USER_MODE];
        return Page.Orders_and_Products;
    }
}