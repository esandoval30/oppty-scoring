sfdx force:org:create -f config/project-scratch-def.json -d 7 -s -w 3
#push source code into scratch org
sfdx force:source:push -f
#create user
sfdx force:user:password:generate
#Create 'ALL AEs' Account to be the parent of all AE Contact Records
sfdx force:data:record:create -s Account -v "Name='ALL AEs' External_ID__c=1"
#Bulk Load ALL AEs into Contact Object
sfdx force:data:bulk:upsert -s Contact -f data/AEs-1.csv -i External_ID__c
#Bulk Load ALL Client (Accounts) linked to their corresponding AE
sfdx force:data:bulk:upsert -s Account -f data/Account.csv -i External_ID__c
#Bulk Load ALL Opportunities
sfdx force:data:bulk:upsert -s Opportunity -f data/AllOpportunities.csv -i External_ID__c
#open the scratch org -- 
sfdx force:org:open -p /setup/SetupOneHome/home
