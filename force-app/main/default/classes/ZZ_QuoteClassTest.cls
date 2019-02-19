@isTest
private class ZZ_QuoteClassTest {

    /**
     * テスト対象
     * createQuote1
     *
     * 条件
     * 権限ありのユーザ
     *
     * 結果
     * 作成
     */
    @isTest 
    static void testCreateQuote_001() {
        
        // テストデータ
        List<Profile> pro = [SELECT ID FROM Profile WHERE Name = 'カスタムプロファイル'];
        
        // ユーザ
        User user = new User();
        user.LastName = 'テストユーザ';
        user.Alias = 'testUser';
        user.Email = 'testmail@example.co.jp';
        user.Username = 'testmail@example.co.jp';
        user.ProfileId = pro[0].Id;
        user.TimeZoneSidKey = 'GMT';
        user.LanguageLocaleKey = 'ja';
        user.EmailEncodingKey = 'ISO-2022-JP';
        user.LocaleSidKey = 'ja_JP';
        insert user;
        
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name ='QuotePermission'][0];
        
        PermissionSetAssignment psa = new PermissionSetAssignment();
        psa.AssigneeId = user.Id;
        psa.PermissionSetId = ps.Id;
        insert psa;
        
        
        System.runAs(user) {
            
            QuoteClass cls = new QuoteClass();
            
            // テスト開始
            Test.startTest();
            
            String ret = cls.createQuote();
            
            // テスト終了
            Test.stopTest();

            // 検証
            System.assertEquals('作成', ret);
            System.assertEquals(1, cls.getQuoteList().size());
        }
    }
    
    /**
     * テスト対象
     * createQuote
     *
     * 条件
     * 権限なしのユーザ
     *
     * 結果
     * 権限なし
     */
    @isTest 
    static void testCreateQuote_002() {
        
        // テストデータ
        List<Profile> pro = [SELECT ID FROM Profile WHERE Name = 'カスタムプロファイル'];
        
        // ユーザ
        User user = new User();
        user.LastName = 'テストユーザ';
        user.Alias = 'testUser';
        user.Email = 'testmail@example.co.jp';
        user.Username = 'testmail@example.co.jp';
        user.ProfileId = pro[0].Id;
        user.TimeZoneSidKey = 'GMT';
        user.LanguageLocaleKey = 'ja';
        user.EmailEncodingKey = 'ISO-2022-JP';
        user.LocaleSidKey = 'ja_JP';
        insert user;
        
        System.runAs(user) {
            
            QuoteClass cls = new QuoteClass();
            
            // テスト開始
            Test.startTest();
            
            String ret = cls.createQuote();
            
            // テスト終了
            Test.stopTest();

            // 検証
            System.assertEquals('権限エラー', ret);
        }
    }
}