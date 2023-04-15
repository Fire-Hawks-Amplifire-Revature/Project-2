public with sharing class ManageOrdersExtension {
    public String orderId{get; private set;}
    public Order order{get; private set;}
    public OrderItem orderProduct{get; private set;}
    public String product2Id{get; set;}
    public class ProductToAdd{
        public Product2 product{get; set;}
        public Boolean add{get; set;}
        public Integer numberToAdd{get; set;}
    }
    public List<productToAdd> productsToAdd{get; set;}


    private ApexPages.StandardSetController controller;

    public ManageOrdersExtension(ApexPages.StandardSetController ssc) {
        controller = ssc;
        productsToAdd = new List<ProductToAdd>();
        for(Product2 p : [SELECT name FROM Product2]){
            ProductToAdd pAdd = new ProductToAdd();
            pAdd.product = p;
            pAdd.add = false;
            pAdd.numberToAdd = 0;

            productsToAdd.add(pAdd);
        }
        orderId = apexpages.currentpage().getparameters().get('orderId');

        if(orderId != null){
            order = [SELECT orderNumber FROM Order WHERE Id = :this.orderId];
        }
        else {
            order = null;            
        }
    }


    public void addProduct(){
        product2Id = apexpages.currentpage().getparameters().get('product2Id');
        orderProduct = new OrderItem(product2Id=product2Id, orderId=orderId);
        System.debug('Order Product: ' + orderProduct);
    }
}