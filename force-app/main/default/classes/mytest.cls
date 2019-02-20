@isTest
private class mytest {

    @isTest
    static void myUnitTest() {
        myclass demo = new myclass();
        System.assertEquals(demo.getAppVersion(), '1.0.0');
        // Uncomment the following line to cause a build failure
        // System.assert(false);
    }

    @isTest
    static void myUnitTest2() {
        List<PermissionSet> psList = [SELECT Id FROM PermissionSet WHERE Name ='ScratchPermissionSet'];
        System.assertEquals(psList.size(),1);
    }

}
