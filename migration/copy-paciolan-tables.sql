use echlRush

--accounts

SELECT
    [AccountID]
      ,[UpdatedDateTime]
      ,[InternetProfile]
      ,[SystemStatus]
      ,[OriginationTime]
      ,[PrimaryTicketingRepUserID]
      ,[PrimaryGeneralRepUserID]
      ,[PrimaryFundRepUserID]
      ,[PrimaryContactID]
      ,[Status]
      ,[PreferredPhoneTypeCode]
      ,[PreferredEmail]
      ,[PreferredContactMethod]
      ,[PreferredContactMethodCode]
      ,[Announcement]
      ,[LastName]
      ,[FirstName]
      ,[AccountType]
      ,[AccountTypeCode]
      ,[AccountName]
      ,[loadid]
      ,[filename]
INTO [echlRush].[staging].[account_migration]
FROM [echlRush].[staging].[paciolanAccount]


--- accountMerge
SELECT 
     [ParentAccountDbID]
      ,[UpdatedDateTime]
      ,[MergeAccountID]
      ,[ParentAccountID]
      ,[loadid]
      ,[filename] 
INTO [echlRush].[staging].[paciolanAccountMerge_migration]
FROM [echlRush].[staging].[paciolanAccountMerge]
  


--- addresstype
SELECT 
[AccountID]
      ,[UpdatedDateTime]
      ,[SystemStatus]
      ,[RegionName]
      ,[RegionID]
      ,[Country]
      ,[ZipCode]
      ,[State]
      ,[County]
      ,[City]
      ,[Address3]
      ,[Address2]
      ,[Address1]
      ,[CareOf]
      ,[MailName]
      ,[AddressType]
      ,[AddressTypeCode]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanAddressType]
INTO [echlRush].[staging].[paciolanAddressType_migration]


--- barcode
SELECT 
[Barcode]
      ,[LastUpdate]
      ,[Scanned]
      ,[ScanResponseCode]
      ,[ScanGate]
      ,[ScanCluster]
      ,[ScanLocation]
      ,[ScanDateTime]
      ,[Seat]
      ,[Row]
      ,[Section]
      ,[Level]
      ,[PriceLevelCode]
      ,[PriceTypeCode]
      ,[EventCode]
      ,[ItemCode]
      ,[SeasonCode]
      ,[StatusName]
      ,[StatusCode]
      ,[AccountID]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanBarcode]
INTO [echlRush].[staging].[paciolanBarcode_migration]


--- billplantype
SELECT 
[SeasonCode]
      ,[LastUpdate]
      ,[BillPlanPercentage]
      ,[BillPlanDate]
      ,[BillPlanTypeName]
      ,[VMC]
      ,[BillPlanTypeCode]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanBillPlanType]
INTO [echlRush].[staging].[paciolanBillPlanType_migration]


--- contact
SELECT 
[AccountID]
      ,[UpdatedDateTime]
      ,[SystemStatus]
      ,[BirthDate]
      ,[NickName]
      ,[Suffix]
      ,[LastName]
      ,[MiddleName]
      ,[FirstName]
      ,[Title]
      ,[IsPrimaryContact]
      ,[ContactID]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanContact]
INTO [echlRush].[staging].[paciolanContact_migration]


--- email
SELECT 
[AccountID]
      ,[UpdateDateTime]
      ,[SystemStatus]
      ,[EmailAddress]
      ,[EmailAddrType]
      ,[EmailAddrTypeCode]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanEmail]
INTO [echlRush].[staging].[paciolanEmail_migration]


--- event
SELECT 
[SeasonCode]
      ,[OrderQty]
      ,[OrderAmt]
      ,[LastUpdate]
      ,[SeatsComp]
      ,[SeatsKilled]
      ,[SeatsHeld]
      ,[SeatsPrinted]
      ,[SeatsAllocated]
      ,[SeatsRemaining]
      ,[Capacity]
      ,[EventConfigName]
      ,[EventConfigCode]
      ,[FacilityName]
      ,[FacilityCode]
      ,[EventClassName]
      ,[EventClassCode]
      ,[EventGroupName]
      ,[EventGroupCode]
      ,[EventDateTime]
      ,[EventBasisName]
      ,[BasisCode]
      ,[EventTypeName]
      ,[EventTypeCode]
      ,[EventName]
      ,[EventCode]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanEvent]
INTO [echlRush].[staging].[paciolanEvent_migration]


--- eventorderdetail
SELECT 
[SeasonCode]
      ,[SurchargePayAmount]
      ,[SurchargeAmount]
      ,[SurchargeCode]
      ,[TicketChargePayAmount]
      ,[TicketChargeAmount]
      ,[TicketChargePrice]
      ,[TicketChargeName]
      ,[TicketChargeCode]
      ,[FacilityFeePayAmount]
      ,[FacilityFeeAmount]
      ,[FacilityFeePrice]
      ,[SeatBlocks]
      ,[InternetRefSource]
      ,[InternetRefData]
      ,[SalcodeCode]
      ,[BillPlanTypeCode]
      ,[PriceLevelCode]
      ,[PriceTypeCode]
      ,[EventPayAmount]
      ,[EventPrice]
      ,[EventQuantity]
      ,[EventCode]
      ,[VMC]
      ,[SEQ]
      ,[AccountId]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanEventOrderDetail]
INTO [echlRush].[staging].[paciolanEventOrderDetail_migration]


--- item order detail
SELECT 
[SeasonCode]
      ,[EventCodes]
      ,[SurchargePayAmount]
      ,[SurchargeAmount]
      ,[SurchargeCode]
      ,[TicketChargePayAmount]
      ,[TicketChargeAmount]
      ,[TicketChargePrice]
      ,[TicketChargeName]
      ,[TicketChargeCode]
      ,[FacilityFeePayAmount]
      ,[FacilityFeeAmount]
      ,[FacilityFeePrice]
      ,[FirstEventSeatBlocks]
      ,[MarkName]
      ,[MarkCode]
      ,[AssocAccountId]
      ,[DiscountAmount]
      ,[DiscountName]
      ,[DiscountCode]
      ,[DispositionName]
      ,[DispositionCode]
      ,[PromoName]
      ,[PromoCode]
      ,[InternetRefSource]
      ,[InternetRefData]
      ,[SalcodeCode]
      ,[BillPlanTypeCode]
      ,[PriceLevelCode]
      ,[PriceTypeCode]
      ,[ItemPayAmount]
      ,[ItemPrice]
      ,[ItemQuantity]
      ,[ItemCode]
      ,[Date]
      ,[SEQ]
      ,[AccountId]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanItemOrderDetail]
INTO [echlRush].[staging].[paciolanItemOrderDetail_migration]


--- odetdelete
SELECT 
[SeasonCode]
      ,[SEQ_DEL]
      ,[AccountID]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanOdetDelete]
INTO [echlRush].[staging].[paciolanOdetDelete_migration]

--- phone
SELECT 
[AccountID]
      ,[UpdateDateTime]
      ,[SystemStatus]
      ,[PhoneNumber]
      ,[DoNotCall]
      ,[PhoneType]
      ,[PhoneTypeCode]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanPhone]
INTO [echlRush].[staging].[paciolanPhone_migration]


--- pricelevel
SELECT 
[SeasonCode]
      ,[LastUpdate]
      ,[PriceLevelName]
      ,[PriceLevelCode]
      ,[ItemCode]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanPriceLevel]
INTO [echlRush].[staging].[paciolanPriceLevel_migration]


--- season
SELECT 
[SeasonCode]
      ,[LastUpdate]
      ,[Status]
      ,[PrevSeasonCode]
      ,[ActivityName]
      ,[ActivityCode]
      ,[SeasonName]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanSeason]
INTO [echlRush].[staging].[paciolanSeason_migration]


--- seats
SELECT 
[LastUpdate]
      ,[SoldPrice]
      ,[AreaName]
      ,[AreaCode]
      ,[Gate]
      ,[Aisle]
      ,[ReservedForMP]
      ,[Barcode]
      ,[PriceLevelCode]
      ,[PriceTypeCode]
      ,[ItemCode]
      ,[AccountId]
      ,[OrderDetailKey]
      ,[PreviousSeatStatusCode]
      ,[SeatStatusName]
      ,[SeatStatusCode]
      ,[Seat]
      ,[VMC]
      ,[Row]
      ,[Section]
      ,[Level]
      ,[EventCode]
      ,[SeasonCode]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanSeat]
INTO [echlRush].[staging].[paciolanSeat_migration]


--- stubhub
SELECT 
[SeasonCode]
      ,[ResaleValue]
      ,[OriginalTicketAmount]
      ,[SeatBlock]
      ,[Quantity]
      ,[EventCode]
      ,[SalecodeCode]
      ,[ResaleDate]
      ,[TransType]
      ,[AccountId]
      ,[TransNumber]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanStubhub]
INTO [echlRush].[staging].[paciolanStubhub_migration]


--- transitemevents
SELECT 
[SeasonCode]
      ,[SeatBlocks]
      ,[SurchargePayAmount]
      ,[SurchargeAmount]
      ,[SurchargeCode]
      ,[TicketChargePayAmount]
      ,[TicketChargeAmount]
      ,[TicketChargePrice]
      ,[TicketChargeName]
      ,[TicketChargeCode]
      ,[FacilityFeePayAmount]
      ,[FacilityFeeAmount]
      ,[FacilityFeePrice]
      ,[EventPayAmount]
      ,[EventAmount]
      ,[EventPrice]
      ,[EventQuantity]
      ,[TransActivityType]
      ,[TransActivityName]
      ,[TransActivityCode]
      ,[InternetRefSource]
      ,[InternetRefData]
      ,[SalcodeCode]
      ,[BillPlanTypeCode]
      ,[PriceLevelCode]
      ,[PriceTypeCode]
      ,[ItemCode]
      ,[EventCode]
      ,[Date]
      ,[AccountId]
      ,[SVMC]
      ,[VMC]
      ,[TransNumber]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanTransItemEvent]
INTO [echlRush].[staging].[paciolanTransItemEvent_migration]


--- transitems

SELECT 
[SeasonCode]
      ,[SurchargePayAmount]
      ,[SurchargeAmount]
      ,[SurchargeCode]
      ,[TicketChargePayAmount]
      ,[TicketChargeAmount]
      ,[TicketChargePrice]
      ,[TicketChargeName]
      ,[TicketChargeCode]
      ,[FacilityFeePayAmount]
      ,[FacilityFeeAmount]
      ,[FacilityFeePrice]
      ,[ItemPayAmount]
      ,[ItemAmount]
      ,[ItemPrice]
      ,[ItemQuantity]
      ,[TransActivityType]
      ,[TransActivityName]
      ,[TransActivityCode]
      ,[AssocAccountId]
      ,[DiscountAmount]
      ,[DiscountName]
      ,[DiscountCode]
      ,[DispositionName]
      ,[DispositionCode]
      ,[PromoName]
      ,[PromoCode]
      ,[InternetRefSource]
      ,[InternetRefData]
      ,[SalcodeCode]
      ,[BillPlanTypeCode]
      ,[PriceLevelCode]
      ,[PriceTypeCode]
      ,[ItemCode]
      ,[Date]
      ,[AccountId]
      ,[VMC]
      ,[TransNumber]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanTransItem]
INTO [echlRush].[staging].[paciolanTransItem_migration]


---
SELECT 

FROM [echlRush].[staging].[test]
INTO [echlRush].[staging].[test_migration]


accounts_merge
accounts
address_types
barcodes
bill_plan_types
contacts
emails
event_order_details
events
item_order_details
odet_deletes
phones
price_levels
price_types
seasons
seats
stubhub_transactions
trans_item_events
trans_items