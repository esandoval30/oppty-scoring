trigger OpportunityTrigger on Opportunity (before insert) {
    
    Datetime today = System.today();
    
    if (Trigger.isInsert) {
        for(Opportunity o : Trigger.New) {
            //set created date to a random number of days before CloseDate
            Integer daysOpen = -1 * (2 + Integer.valueof((Math.random() * 100)));
            Datetime newCreatedDate = o.CloseDate.addDays(daysOpen); 
            if (newCreatedDate >= today) {
                //bring back to a date prior to today
                daysOpen = -1 * (1 + Integer.valueof((Math.random() * 50)));
                o.CreatedDate = today.addDays(daysOpen);
            } else {
                o.CreatedDate  = newCreatedDate;
            }           
    	}
    }
}