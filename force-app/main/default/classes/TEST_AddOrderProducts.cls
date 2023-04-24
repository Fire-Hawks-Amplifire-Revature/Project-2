@isTest
public with sharing class TEST_AddOrderProducts {
    @isTest
    public static void addProduct(){
        Pagereference pr = Page.Add_Order_Products;
        Test.setCurrentPage(pr);
        Database.QueryLocator q = Database.getQueryLocator([SELECT Name FROM Product2]);

        ApexPages.StandardSetController ssc = ApexPages.StandardSetController(q);
        AddOrderProductsExtension controller = new AddOrderProductsExtension(ssc);
    }
}