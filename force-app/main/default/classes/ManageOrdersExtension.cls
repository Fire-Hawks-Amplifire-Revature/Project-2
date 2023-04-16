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


    public void addProducts(){
        System.debug(controller.getRecords()[0]);
    }
}