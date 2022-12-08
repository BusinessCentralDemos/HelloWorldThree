// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 70074167 MS_CustomerListExt3 extends "Customer List"
{
    trigger OnOpenPage();
    begin
        Message('App published: Hello world');
    end;
}

permissionset 70074167 "Mypermissionset"
{
    Assignable = true;
    Caption = 'sample permission set';

    Permissions = codeunit MyCodeunit = X;
}

permissionset 70074168 "MypermissionsetSuper"
{
    Assignable = true;
    Caption = 'super permission set';
    Permissions = page * = X;
}

entitlement "MyOfferEntitlement"
{
    Type = PerUserOfferPlan;
    Id = 'mdcc1667400477212.kckofferid.planidkck';
    ObjectEntitlements = "Mypermissionset";
}

entitlement "MyEntitlement"
{
    Type = PerUserServicePlan;
    Id = '3f2afeed-6fb5-4bf9-998f-f2912133aead';
    ObjectEntitlements = "MypermissionsetSuper";
}
codeunit 70074168 MyCodeunit
{
    trigger OnRun()
    begin
        Message('Yes, access to MyCodeunit!');
    end;
}

page 70074168 SampleCustomerCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;

    //Defines the names for promoted categories for actions.
    PromotedActionCategories = 'New,Process,Report,Manage,New Document,Request Approval,Customer';

    layout
    {
        area(Content)
        {
            //Defines a FastTab that has the heading 'General'.
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Customer; rec.Name)
                {
                    ApplicationArea = All;

                }
            }

            //Defines a FastTab that has the heading 'Contact'.
            group(Contact)
            {
                field(Name; rec.Contact)
                {
                    ApplicationArea = All;

                }
                field(Phone; rec."Phone No.")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Check Access")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = NewSalesQuote;
                trigger OnAction();
                begin
                    Codeunit.Run(70074168);
                end;
            }
        }
    }
    var
        myInt: Integer;
}