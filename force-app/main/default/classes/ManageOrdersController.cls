public with sharing class ManageOrdersController {
    public String orderId{get;set;}
    public Order order{get;set;}

    public ManageOrdersController() {
        this.orderId = apexpages.currentpage().getparameters().get('orderId');



        if(orderId != null){
            this.order = [SELECT orderNumber FROM Order WHERE Id = :this.orderId];
        }
        else {
            this.order = null;            
        }
    }

    public void test123(){
        //this.order.save();
        System.debug('order: ' + this.order);
        System.debug('order - account ID: ' + this.order.accountId);
        //Database.insert(this.order);
    }
}