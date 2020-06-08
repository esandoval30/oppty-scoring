public without sharing class OpportunityTriggerHandler {
    
    public void OnBeforeInsert(Opportunity[] opportunities) {
		//set created date to a random number of days before CloseDate
		setCreatedDate(opportunities);
    }
    
    private void setCreatedDate(Opportunity[] opportunities) {
        Datetime today = System.today();
        for(Opportunity o : opportunities) {
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

    public void OnAfterInsert(Opportunity[] opportunities) {
		//set randomDiscount to Closed Opportunities
		setRandomDiscount(opportunities);
    }
        
       
    private void setRandomDiscount(Opportunity[] opportunities) {
        Set<Id> closedOppIds = new Set<Id>();
        String won = 'Closed Won';
        String lost = 'Closed Lost';
        for (Opportunity o: opportunities) {
            if (won.equals(o.StageName) || lost.equals(o.StageName)) {
                closedOppIds.add(o.Id);
            }
        }

        Opportunity[] oppsToUpdate = [SELECT Id, Amount from Opportunity where id in :closedOppIds];
        for (Opportunity o  : oppsToUpdate ) {
            Integer amountPctChange = 1 +  Integer.valueof(Math.random() * 5);
            amountPctChange = Math.random() < 0.5 ? -1*amountPctChange : amountPctChange;
            o.Amount += o.Amount * amountPctChange / 100;
        }
        
        if (oppsToUpdate!=null && oppsToUpdate.size() > 0) {
	        update oppsToUpdate;
        }
        
        
    }
   
}