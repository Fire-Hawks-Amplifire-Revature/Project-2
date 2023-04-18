public with sharing class CreateOrderExtension {
    private ApexPages.StandardController controller;
    public Order order{get; private set;}

    public CreateOrderExtension(ApexPages.StandardController sc) {
        controller = sc;
        this.order = new Order();
    }

    public PageReference customSave(){
        insert this.order;
        System.debug('Test 1: ' + this.order.Id);

        PageReference pR = Page.Manage_Orders;
        pR.getParameters().put('orderid', this.order.Id);

        return pR;
    }
}