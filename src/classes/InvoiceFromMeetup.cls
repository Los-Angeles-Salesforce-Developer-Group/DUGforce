public class InvoiceFromMeetup{
    public Meetup__c meetup{get; set;}
    public Expense__c[] meetupExpenses{get; set;}
    public Invoice__c newInvoice{get; set;}
    public InvoiceLineItem__c[] invLineItems{get; set;}
    
    public InvoiceFromMeetup(ApexPages.StandardController stdCtrlr){
        this.meetup = (Meetup__c)stdCtrlr.getRecord();
        
    }
}