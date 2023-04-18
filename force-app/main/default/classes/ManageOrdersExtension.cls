public with sharing class ManageOrdersExtension {
    public String orderId{get; private set;}
    public Order order{get; private set;}
    public List<OrderItem> oldOrderProducts{get; private set;}
    public List<OrderItem> orderProductsToAdd{get; private set;}
    public List<PricebookEntry> pricebookEntries{get; private set;}
    public List<Product2> productsList{get; private set;}

    private ApexPages.StandardSetController controller;

    public ManageOrdersExtension(ApexPages.StandardSetController ssc) {
        controller = ssc;
        orderId = apexpages.currentpage().getparameters().get('orderId');
        orderProductsToAdd = new List<OrderItem>();
        productsList = controller.getRecords();
        pricebookEntries = new List<PricebookEntry>();

        order = [SELECT orderNumber, pricebook2Id FROM Order WHERE Id = :orderId];

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
        productsList = controller.getRecords();
        //add an error here if the order doesn't have an associated pricebook yet
        pricebookEntries = [SELECT Id, pricebook2Id, product2Id FROM PricebookEntry WHERE pricebook2Id=:order.pricebook2Id];

        // for(Product2 p : productsList){
        //     if(p.add_to_order__c){
        //         for(PricebookEntry pE : pricebookEntries){
        //             System.debug('Price Book Entry - Product Id: ' + pE.product2Id);
        //             System.debug('Product List Product - Id: ' + p.Id);
        //             if(pE.product2Id == p.Id){
        //                 orderProductsToAdd.add(new OrderItem(orderId=orderId, product2Id=p.Id, quantity=p.number_to_add__c, unitPrice=10, pricebookEntryId=pE.Id));
        //             }
        //         }
        //     }
        // }

        for(Product2 p : productsList){
            if(p.add_to_order__c){
                for(PricebookEntry pE : pricebookEntries){
                    if(pE.product2Id == p.Id){
                        orderProductsToAdd.add(new OrderItem(orderId=orderId, product2Id=p.Id, quantity=p.number_to_add__c, unitPrice=10, pricebookEntryId=pE.Id));
                    }
                }
            }
        }
        System.debug('orderProductsToAdd:' + orderProductsToAdd);
        Database.insert(orderProductsToAdd);
        
        resetUpdateFields(productsList);
    }
}
