public with sharing class ManageOrdersController {
    public String orderId{get;set;}
    public Order order{get;set;}

    public ManageOrdersController() {
        this.orderId = apexpages.currentpage().getparameters().get('orderId');

        if(orderId != null){
            this.order = [SELECT orderNumber FROM Order WHERE Id = :this.orderId];
        } else {
            this.order = null;            
        }
    }
}