public with sharing class RemoveOrderProductsExtension {
    private ApexPages.StandardSetController controller;
    public String orderId{get; private set;}
    public Order order{get; private set;}
    public List<OrderItem> oldOrderProducts{get; private set;}
    public List<OrderItem> orderProductsToDelete{get; private set;}


    public RemoveOrderProductsExtension(ApexPages.StandardSetController ssc) {
        controller = ssc;
        orderId = apexpages.currentpage().getparameters().get('orderId');
        order = [SELECT orderNumber, pricebook2Id, Account.name, Contract.contractNumber, effectiveDate, totalAmount, status FROM Order WHERE id=:orderId];
        oldOrderProducts = [SELECT Product2.name, quantity, do_update_order__c, PricebookEntry.unitPrice FROM OrderItem WHERE orderId =:orderId];
        orderProductsToDelete = new List<OrderItem>();
    }

    public void removeProducts(){
        for(OrderItem oi : oldOrderProducts){
            if(oi.do_update_order__c == true){
                orderProductsToDelete.add(oi);
            }
        }
        delete orderProductsToDelete;
        orderProductsToDelete = new List<OrderItem>();
        oldOrderProducts = [SELECT Product2.name, quantity, do_update_order__c, PricebookEntry.unitPrice FROM OrderItem WHERE orderId =:orderId];
        order = [SELECT orderNumber, pricebook2Id, Account.name, Contract.contractNumber, effectiveDate, totalAmount, status FROM Order WHERE Id = :orderId];
    }
}