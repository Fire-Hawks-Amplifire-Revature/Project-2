public class CSSTriggerHelper {
    


   public CSSTriggerHelper(List<Customer_Success_Story__c> cssList)
   {
    //List<Customer_Success_Story__c> cssList= cssMap.values();
        Integer numCSS= cssList.size();
        //List<Integer> sameasPrev =new List<Integer>[numCSS];//use later to define ties as the same rating

        //List<Customer_Success_Story__c> sortedList= new List<Customer_Success_Story__c[numCSS];
       // quicksortCSS(cssList,0,numCSS);

        List<Decimal> ratingsVals=new List<Decimal>();

        for(Customer_Success_Story__c CS_S:cssList)
        {
            ratingsVals.add(CS_S.Rating__c);
        }

        ratingsVals.sort();

        for(Customer_Success_Story__c CS_S:cssList)
        {
            for(Integer c=0;c<numCSS;c++)
            {
                //CS_S.Ranking__c=numCSS;
                if(ratingsVals[c]==CS_S.Rating__c)//if the               ating is the same as the value of a sorted rating
                {
                   System.debug(CS_S);
                    CS_S.Ranking__c=c+1;//set theranking to the list value (+1)
                    c=numCSS;//break the for loop
                }
            }
        }
        
        update(cssList);
   }

  /* public static void quicksortCSS(List<Customer_Success_Story__c> cssList,Integer lo, Integer hi)
   {


   }
   public static Integer partition(List<Customer_Success_Story__c> cssList,Integer lo, Integer hi)
   {



   }*/

}