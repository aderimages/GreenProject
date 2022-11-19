public class leadUI {
    @AuraEnabled
    public static String CreateAd(Ad__c singleAd) { 
        List<Campaign> singleCampaign = new List<Campaign>();
        String searchCamp = '%' + singleAd.UTM_Source__c +'%'; // like %Webinar% in Flow
        String Result;
        singleCampaign = [SELECT Id, Name, IsActive 
        FROM Campaign WHERE (Name LIKE :SearchCamp AND ISActive =True) LIMIT 1];

        if(singleCampaign.size() == 0){
            insert singleAd;
        }else{
            singleAd.Campaign__c = singleCampaign.get(0).id;
            insert singleAd;
        }

        Result = singleAd.Id;

        return Result;
    }

    @AuraEnabled
    public static String CreateLead(Lead singleLead, String Search) {
        List<Campaign> singleCampaign = new List<Campaign>();
        CampaignMember singleCampaignMember = new CampaignMember();
        String searchCamp = '%' + Search +'%'; 
        String Result;
        singleCampaign = [SELECT Id, Name, IsActive 
        FROM Campaign WHERE (Name LIKE :SearchCamp AND ISActive =True) LIMIT 1];

        if(singleCampaign.size() == 0){
            insert singleLead;
        }else{
            insert singleLead;
            singleCampaignMember.CampaignId = singleCampaign.get(0).Id;
            singleCampaignMember.LeadId = singleLead.Id;
            singleCampaignMember.Status = 'Received';
            
            insert singleCampaignMember;
        }

        Result = singleLead.Id;

        return Result;
    }
}
