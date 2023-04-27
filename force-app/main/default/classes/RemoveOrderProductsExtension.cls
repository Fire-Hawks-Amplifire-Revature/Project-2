public with sharing class RemoveOrderProductsExtension {
    public String orderId{get; private set;}
    public Order order{get; private set;}
    public List<OrderItem> oldOrderProducts{get; private set;}
    public List<OrderItem> orderProductsToDelete{get; private set;}

    private ApexPages.StandardSetController controller;

    public RemoveOrderProductsExtension(ApexPages.StandardSetController ssc) {
        controller = ssc;
        orderId = apexpages.currentpage().getparameters().get('orderId');
        order = [SELECT orderNumber, pricebook2Id, Account.name, Contract.contractNumber, effectiveDate, totalAmount, status FROM Order WHERE id=:orderId WITH USER_MODE];
        oldOrderProducts = [SELECT Product2.name, quantity, do_update_order__c, PricebookEntry.unitPrice FROM OrderItem WHERE orderId =:orderId WITH USER_MODE];
        orderProductsToDelete = new List<OrderItem>();
    }

    public Pagereference removeProducts(){
        for(OrderItem oi : oldOrderProducts){
            if(oi.do_update_order__c == true){
                orderProductsToDelete.add(oi);
            }
        }

        try {
            delete orderProductsToDelete;
        } catch(System.DmlException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, 'This Line Item has already been deleted. Be careful not to double-click \"Remove Line Item\".'));
            orderProductsToDelete = new List<OrderItem>();
            oldOrderProducts = [SELECT Product2.name, quantity, do_update_order__c, PricebookEntry.unitPrice FROM OrderItem WHERE orderId =:orderId WITH USER_MODE];
            order = [SELECT orderNumber, pricebook2Id, Account.name, Contract.contractNumber, effectiveDate, totalAmount, status FROM Order WHERE Id = :orderId WITH USER_MODE];
            return Page.Remove_Order_Products;
        }

        orderProductsToDelete = new List<OrderItem>();
        oldOrderProducts = [SELECT Product2.name, quantity, do_update_order__c, PricebookEntry.unitPrice FROM OrderItem WHERE orderId =:orderId WITH USER_MODE];
        order = [SELECT orderNumber, pricebook2Id, Account.name, Contract.contractNumber, effectiveDate, totalAmount, status FROM Order WHERE Id = :orderId WITH USER_MODE];
        return Page.Remove_Order_Products;
    }
}