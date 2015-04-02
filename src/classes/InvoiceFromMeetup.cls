public class InvoiceFromMeetup{
    public Meetup__c meetup{get; set;}
    public Expense__c[] meetupExpenses{get; set;}
    public Invoice__c newInvoice{get; set;}
    public InvoiceLineItem__c[] invLineItems{get; set;}
    
    public InvoiceFromMeetup(ApexPages.StandardController stdCtrlr){
        this.meetup = (Meetup__c)stdCtrlr.getRecord();
        
        // Generate Invoice from Meetup
        this.newInvoice = new Invoice__c();
        this.newInvoice.Date__c = Date.today();
        this.newInvoice.InvoiceNumber__c = String.valueOf(this.newInvoice.Date__c);
    }

    public PageReference generateInvoice() {
        // bill to should default on trigger
        insert this.newInvoice;

        this.meetupExpenses = [
            SELECT Id, Name, Amount__c, Date__c, Description__c, Invoice_Line_Item__c
            FROM   Expense__c
            WHERE  Meetup__c = :this.meetup.Id
        ];
        return null;
    }

    public PageReference generateLineItems() {
        this.invLineItems = new InvoiceLineItem__c[]{};
        for(Expense__c meetupExpense : this.meetupExpenses){
            InvoiceLineItem__c invLineItem = new InvoiceLineItem__c();
            invLineItem.Invoice__c = this.newInvoice.Id;
            invLineItem.Amount__c = meetupExpense.Amount__c;
            invLineItem.Description__c = meetupExpense.Description__c;
            this.invLineItems.add(invLineItem);
        }
        return new PageReference('/'+this.newInvoice.Id);
    }
}