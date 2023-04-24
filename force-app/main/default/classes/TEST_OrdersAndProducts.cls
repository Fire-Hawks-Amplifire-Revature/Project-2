@isTest
public with sharing class TEST_OrdersAndProducts {
    @TestSetup
    public static void makeData(){
        Account acc = new Account(name = 'Test Account');
        insert acc;

        Pricebook2 pricebook = new Pricebook2(name = 'Test Pricebook');
        insert pricebook;

        Date newDate = Date.today();
        Contract contract = new Contract(accountId = acc.id, status = 'Draft', startDate = newDate, contractTerm = 100);

        Order order = new Order(name='Test Order', accountId = acc.id, contractId = contract.Id, effectiveDate = newDate, status = 'Draft', pricebook2Id = pricebook.id);
        insert order;
    }

    @isTest
    public static void deleteAnOrder(){
        Pagereference pr = Page.Orders_And_Products;
        Test.setCurrentPage(pr);
        OrdersAndProductsController controller = new OrdersAndProductsController();

        controller.deleteOrder();

        Order order = [SELECT Id, OrderNumber FROM Order WHERE name = 'Test Order'];

        pr.getParameters().put('orderId', order.id);

        controller.deleteOrder();

        Integer nOrdersAfterDelete = [SELECT COUNT() FROM Order WHERE name = 'Test Order'];
        System.assertEquals(0, nOrdersAfterDelete);
    }
}