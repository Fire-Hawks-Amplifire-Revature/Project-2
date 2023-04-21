public with sharing class CreateOrderExtension {
    private ApexPages.StandardController controller;
    public Order order{get; private set;}

    public CreateOrderExtension(ApexPages.StandardController sc) {
        controller = sc;
        this.order = new Order();
    }

    public PageReference customSave(){
        if (Schema.sObjectType.Order.isCreateable()) {
            insert this.order;
            System.debug('Test 1: ' + this.order.Id);
    
            PageReference pR = Page.Add_Order_Products;
            pR.getParameters().put('orderid', this.order.Id);
    
            return pR;
         } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'You do not have permission to create new'));
            PageReference pR = Page.Create_Orders;
            return pr;
         }

    }
}