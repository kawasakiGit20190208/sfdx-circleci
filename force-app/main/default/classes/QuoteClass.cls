public class QuoteClass {
    
    /**
     * コンストラクタ
     */
    public QuoteClass() { 
    }
    
    /**
     * 取引先の作成
     */
    public String createQuote() {
        
        if (!isCreatableQuote()) {
            return '権限エラー';
        }
        try {
            Quote__c quo = new Quote__c();
            quo.name = 'Test' + getRandomString(5);
            quo.Amount__c = 1000;
            insert quo;  
        } catch(Exception e) {
            System.debug('★★'+ e.getMessage());
        }       
        return '作成';
    }
    
    /**
     * 権限チェック
     */
    private Boolean isCreatableQuote() {
        return Schema.sObjectType.Quote__c.isCreateable();
    }
    
    /**
     * 取引先の取得
     */
    public List<Quote__c> getQuoteList() {
        return [SELECT Id, Amount__c, Name FROM Quote__c LIMIT 1]; 
    }
    
    /**
     * ランダムな文字列生成
     */
    public string getRandomString(Integer LengthRequired){ 
        // 使用する文字
        String charList = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_';
        String res = '';
        
        Integer position;
        
        // ランダムな文字列の生成
        for (Integer i = 0 ; i <= LengthRequired ; i++) {
            position = Integer.valueof(String.valueof(Math.roundToLong(charList.length()*Math.random()))) -1;
            position = (position < 0 ? 0 : position);
            res += CharList.substring(position,position+1);
        }
        return res;
    }
    
}