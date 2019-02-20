public class AccountClass {
    
    /**
     * コンストラクタ
     */
    public AccountClass() {  
    }
    
    /**
     * 取引先の作成
     */
    public Account createAccount() {
        
        Account acc = new Account();
        acc.name = 'Test' + getRandomString(5);
        insert acc;

		Account acc2 = new Account();
        acc2.name = 'Test' + getRandomString(5);
        insert acc2;
        
        // 作成した取引先返却
        return acc;
    }
    
    /**
     * 取引先の取得
     */
    public List<Account> getAccountList() {
        return [SELECT Id, Name FROM Account LIMIT 1]; 
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