@isTest
private class ZZ_AccountClassTest {

    /**
     * テスト対象
     *  createAccount
     *
     * 条件
     *  なし
     *
     * 結果
     *  1件作成
     */
    @isTest 
    static void testCreateAccount_001() {
        
        AccountClass con = new AccountClass();
        
        // テスト開始
        Test.startTest();
        
        con.createAccount();
        
        // テスト終了
        Test.stopTest();

        // 検証
        List<Account> ret = [SELECT Id FROM Account];
        
        // わざとエラーにする
        // 再度チャレンジ
        System.assertEquals(2, ret.size());
    }
    
    /**
     * テスト対象
     *  createAccount
     *
     * 条件
     *  なし
     *
     * 結果
     *  1件作成
     */
    @isTest 
    static void testGetAccountList_001() {
        
        AccountClass con = new AccountClass();
        
        // 取引先作成
        con.createAccount();
        
        // テスト開始
        Test.startTest();
        
        List<Account> ret = con.getAccountList();
        
        // テスト終了
        Test.stopTest();

        // 検証
        System.assertEquals(1, ret.size());
    }
}