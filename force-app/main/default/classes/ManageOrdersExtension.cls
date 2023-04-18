public with sharing class ManageOrdersExtension {
    public String orderId{get; private set;}
    public Order order{get; private set;}
    public List<OrderItem> oldOrderProducts{get; private set;}
    public List<OrderItem> orderProductsToAdd{get; private set;}

    private ApexPages.StandardSetController controller;

    public ManageOrdersExtension(ApexPages.StandardSetController ssc) {
        controller = ssc;
        orderId = apexpages.currentpage().getparameters().get('orderId');
        orderProductsToAdd = new List<OrderItem>();

        order = [SELECT orderNumber FROM Order WHERE Id = :this.orderId];
        oldOrderProducts = [SELECT product2.name, quantity FROM OrderItem WHERE orderId = :orderId];

        controller.setPageSize(30);
    }

    public void resetUpdateFields(List<Product2> rProducts){
        for(Product2 p : rProducts){
            p.number_to_add__c = null;
            p.add_to_order__c = false;
        }
    }

    public void addProducts(){
        List<Product2> productsList = controller.getRecords();
        for(Product2 p : productsList){
            if(p.add_to_order__c){
                orderProductsToAdd.add(new OrderItem(orderId=orderId, product2Id=p.Id, quantity=p.number_to_add__c, unitPrice=10));
            }
        }
        System.debug('orderProductsToAdd:' + orderProductsToAdd);
        List<Database.SaveResult> sr = Database.insert(orderProductsToAdd);
        
        resetUpdateFields(productsList);
    }
}
