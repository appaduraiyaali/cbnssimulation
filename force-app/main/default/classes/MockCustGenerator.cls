@isTest
global class MockCustGenerator implements HttpCalloutMock
{
    global HTTPResponse respond(HTTPRequest req)
    {
        HTTPResponse res = new HTTPResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"customer":{"allow_direct_debit":false,"excess_payments":0,"net_term_days":0,"promotional_credits":0,"last_name":"Doe","created_at":1528093935,"billing_address":{"zip":"91789","country":"US","city":"Walnut","last_name":"Doe","state":"California","validation_status":"not_validated","state_code":"CA","first_name":"John","line1":"PO Box 9999","object":"billing_address"},"unbilled_charges":0,"taxability":"taxable","locale":"fr-CA","resource_version":1528093935000,"card_status":"no_card","deleted":false,"preferred_currency_code":"USD","auto_collection":"on","updated_at":1528093935,"id":"5SK0b8q3QtywQ7J8W","first_name":"John","email":"john@test.com","refundable_credits":0,"object":"customer"}}');
        res.setStatusCode(200);
        return res;
    }


}