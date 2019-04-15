@isTest
global class MockCancelResponseGenerator implements HttpCalloutMock
{
    global HTTPResponse respond(HTTPRequest req)
    {
        HTTPResponse res = new HTTPResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"subscription":{"billing_period":1,"cancelled_at":1528093938,"plan_free_quantity":0,"billing_period_unit":"month","current_term_start":1527791442,"created_at":1412101842,"resource_version":1528093938000,"currency_code":"USD","updated_at":1528093938,"id":"8avVGOkx8U1MX","shipping_address":{"zip":"91789","country":"US","city":"Walnut","last_name":"Ross","state":"California","validation_status":"not_validated","state_code":"CA","first_name":"Benjamin","line1":"PO Box 9999","object":"shipping_address"},"has_scheduled_changes":false,"due_invoices_count":3,"plan_quantity":1,"trial_end":1414780242,"current_term_end":1528093938,"mrr":0,"plan_unit_price":900,"activated_at":1414780242,"deleted":false,"due_since":1394532759,"total_dues":6700,"trial_start":1412101842,"started_at":1412101842,"customer_id":"8avVGOkx8U1MX","plan_id":"basic","status":"cancelled","object":"subscription"},"card":{"last4":"1881","payment_source_id":"pm_5SK0b8q3QtywPvB8O","gateway_account_id":"gw_5SK0b8vNQtyvEg38O","funding_type":"credit","last_name":"Fox","card_type":"visa","expiry_year":2022,"iin":"401288","expiry_month":10,"issuing_country":"CA","masked_number":"************1881","customer_id":"8avVGOkx8U1MX","first_name":"Richard","gateway":"stripe","status":"valid","object":"card"},"customer":{"allow_direct_debit":false,"excess_payments":0,"net_term_days":0,"promotional_credits":0,"last_name":"Ross","created_at":1412101843,"billing_address":{"zip":"91789","country":"US","city":"Walnut","last_name":"Doe","state":"California","validation_status":"not_validated","state_code":"CA","first_name":"John","line1":"PO Box 9999","object":"billing_address"},"unbilled_charges":0,"taxability":"taxable","resource_version":1528093938000,"card_status":"valid","deleted":false,"preferred_currency_code":"USD","auto_collection":"on","updated_at":1528093938,"id":"8avVGOkx8U1MX","first_name":"Benjamin","primary_payment_source_id":"pm_5SK0b8q3QtywPvB8O","email":"Benjamin@test.com","contacts":[{"last_name":"asas","id":"d334f4g45","label":"ascasc","send_account_email":true,"send_billing_email":false,"first_name":"aasca","email":"sss@wss.asc","enabled":true,"object":"contact"}],"payment_method":{"gateway_account_id":"gw_5SK0b8vNQtyvEg38O","reference_id":"cus_CzAZAU4W3aghnt/card_1CZCEiJv9j0DyntJPjirexdQ","type":"card","gateway":"stripe","object":"payment_method","status":"valid"},"refundable_credits":0,"object":"customer"}}');
        res.setStatusCode(200);
        return res;
    }


}