public with sharing class AddOrderProductsExtension {
    public String orderId{get; private set;}
    public Order order{get; private set;}
    public List<OrderItem> oldOrderProducts{get; private set;}
    public List<OrderItem> orderProductsToAdd{get; private set;}
    public List<PricebookEntry> pricebookEntries{get; private set;}
    public List<Product2> productsList{get; private set;}

    private ApexPages.StandardSetController controller;

    public AddOrderProductsExtension(ApexPages.StandardSetController ssc) {
        controller = ssc;
        orderId = apexpages.currentpage().getparameters().get('orderId');
        orderProductsToAdd = new List<OrderItem>();
        productsList = controller.getRecords();
        pricebookEntries = new List<PricebookEntry>();

        order = [SELECT orderNumber, pricebook2Id, Account.name, Contract.contractNumber, effectiveDate, totalAmount, status FROM Order WHERE Id = :orderId WITH USER_MODE];

        if(order.pricebook2Id == null){
            order.addError('Select a pricebook for this order before adding products');
        }

        oldOrderProducts = [SELECT Product2.name, quantity, do_update_order__c FROM OrderItem WHERE orderId = :orderId WITH USER_MODE];

        controller.setPageSize(30);
    }

    public void resetUpdateFields(List<Product2> rProducts){
        for(Product2 p : rProducts){
            p.number_to_add__c = null;
            p.do_update_order__c = false;
        }
    }

    public void addProducts(){
        productsList = controller.getRecords();
        pricebookEntries = [SELECT Id, pricebook2Id, product2Id FROM PricebookEntry WHERE pricebook2Id=:order.pricebook2Id WITH USER_MODE];

        for(Product2 p : productsList){
            if(p.do_update_order__c){
                if(p.number_to_add__c != null && p.number_to_add__c > 0){
                    for(PricebookEntry pE : pricebookEntries){
                        if(pE.product2Id == p.Id){
                            orderProductsToAdd.add(new OrderItem(orderId=orderId, product2Id=p.Id, quantity=p.number_to_add__c, unitPrice=10, pricebookEntryId=pE.Id));
                        }
                    }
                } else {
                    p.addError('To add a Product you must specify a Quantity!');
                }
            }
        }
        Database.insert(orderProductsToAdd);
        orderProductsToAdd = new List<OrderItem>();
        
        resetUpdateFields(productsList);
        oldOrderProducts = [SELECT Product2.name, quantity, do_update_order__c FROM OrderItem WHERE orderId = :orderId  WITH USER_MODE];
        order = [SELECT orderNumber, pricebook2Id, Account.name, Contract.contractNumber, effectiveDate, totalAmount, status FROM Order WHERE Id = :orderId  WITH USER_MODE];
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> 03ec958a6d0cbf58670c907af1535623bd62c4ff
