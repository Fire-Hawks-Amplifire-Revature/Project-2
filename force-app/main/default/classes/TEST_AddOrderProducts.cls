@isTest
public with sharing class TEST_AddOrderProducts {
    @TestSetup
    static void makeData(){
        Account acc = new Account(name = 'Test Account');
        insert acc;

        Product2 product = new Product2(name='Test Product', IsActive = true);
        insert product;

        Date newDate = Date.today();
        Contract contract = new Contract(accountId = acc.id, status = 'Draft', startDate = newDate, contractTerm = 100);

        Order order = new Order(name='Test Order', accountId = acc.id, contractId = contract.Id, effectiveDate = newDate, status = 'Draft', pricebook2Id = Test.getStandardPricebookId());
        insert order;

        PricebookEntry pEntry = new PricebookEntry(pricebook2Id = Test.getStandardPricebookId(), unitPrice = 10.00, product2Id = product.id);
        insert pEntry;
    }

    @isTest
    public static void addProduct(){
        Pagereference pr = Page.Add_Order_Products;
        Test.setCurrentPage(pr);

        AddOrderProductsController controller = new AddOrderProductsController();

        Order order = [SELECT Id, OrderNumber FROM Order WHERE name = 'Test Order'];

        // add some products to an order - insert order items
        pr.getParameters().put('orderId', order.id);

        // Integer checkOrderItems = [SELECT COUNT() FROM OrderItem WHERE orderId = order.id];
        // System.assertEquals(checkOrderItems, 1);
    }
}