public with sharing class CreateOrderExtension {
    private ApexPages.StandardController controller;

    public CreateOrderExtension(ApexPages.StandardController sc) {
        controller = sc;
    }

    public PageReference customSave(){
        controller.save();
        return Page.Manage_Orders;
    }
}