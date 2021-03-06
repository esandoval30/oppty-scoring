sfdx force:org:create -f config/project-scratch-def.json -d 30 -s -w 3
#push source code into scratch org
sfdx force:source:push
#create user
sfdx force:user:password:generate
#Grant SCE PermSet
sfdx shane:user:permset:assign -n SalesCloudEinsteinAll
#Create 'ALL AEs' Account to be the parent of all AE Contact Records
sfdx force:data:record:create -s Account -v "Name='ALL AEs' External_ID__c=1"
#Bulk Load ALL AEs into Contact Object
sfdx force:data:bulk:upsert -s Contact -w 60 -f data/AEs-1.csv -i External_ID__c
#Bulk Load ALL Client (Accounts) linked to their corresponding AE
sfdx force:data:bulk:upsert -s Account -w 60 -f data/Account.csv -i External_ID__c
#Bulk Load ALL Opportunities (adjusting closedate before load)
sfdx shane:data:dates:update -r 5-21-2020
sfdx force:data:bulk:upsert -s Opportunity -w 60 -f data-modified/AllOpportunities.csv -i External_ID__c
#open the scratch org
sfdx force:org:open -p /lightning/setup/SetupOneHome/home
