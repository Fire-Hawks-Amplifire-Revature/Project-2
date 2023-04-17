public with sharing class ManageOrdersExtension {
    public String orderId{get; private set;}
    public Order order{get; private set;}
    public List<OrderItem> orderProducts{get; private set;}


    private ApexPages.StandardSetController controller;

    public ManageOrdersExtension(ApexPages.StandardSetController ssc) {
        controller = ssc;
        orderId = apexpages.currentpage().getparameters().get('orderId');

        if(orderId != null){
            order = [SELECT orderNumber FROM Order WHERE Id = :this.orderId];
            orderProducts = [SELECT product2.name, quantity FROM OrderItem WHERE orderId = :orderId];
        }
    }

    public void resetUpdateFields(List<Product2> rProducts){
        for(Product2 p : rProducts){
            //reset order update fields
            p.number_to_add__c = null;
            p.add_to_order__c = false;
        }
    }

    public void addProducts(){
        List<Product2> productsList = controller.getRecords();
        for(Product2 p : productsList){
            if(p.add_to_order__c){
                System.debug('Add ' + p.number_to_add__c + 'x \"' + p.name + '\" to Order');
            }
        }
        resetUpdateFields(productsList);
    }
}