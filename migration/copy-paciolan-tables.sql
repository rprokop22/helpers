use echlHeartlanders

-- DROP TABLE [staging].[paciolanAccountMerge_migration];
-- DROP TABLE [staging].[paciolanAccount_migration];
-- DROP TABLE [staging].[paciolanAddressType_migration];
-- DROP TABLE [staging].[paciolanBarcode_migration];
-- DROP TABLE [staging].[paciolanBillPlanType_migration];
-- DROP TABLE [staging].[paciolanContact_migration];
-- DROP TABLE [staging].[paciolanEmail_migration];
-- DROP TABLE [staging].[paciolanEventOrderDetail_migration];
-- DROP TABLE [staging].[paciolanEvent_migration];
-- DROP TABLE [staging].[paciolanItemOrderDetail_migration];
-- DROP TABLE [staging].[paciolanOdetDelete_migration];
-- DROP TABLE [staging].[paciolanPhone_migration];
-- DROP TABLE [staging].[paciolanPriceLevel_migration];
-- DROP TABLE [staging].[paciolanPriceType_migration];
-- DROP TABLE [staging].[paciolanSeason_migration];
-- DROP TABLE [staging].[paciolanSeat_migration];
-- DROP TABLE [staging].[paciolanStubhub_migration];
-- DROP TABLE [staging].[paciolanTransItemEvent_migration];
-- DROP TABLE [staging].[paciolanTransItem_migration];



--accounts

SELECT
   [AccountID],
  [AccountName],
  [AccountType],
  [AccountTypeCode],
  [Announcement],
  [FirstName],
  [InternetProfile],
  [LastName],
  CAST([OriginationTime] AS datetime2) AS OriginationTime,
  [PreferredContactMethod],
  [PreferredContactMethodCode],
  [PreferredEmail],
  [PreferredPhoneTypeCode],
  [PrimaryContactID],
  [PrimaryFundRepUserID],
  [PrimaryGeneralRepUserID],
  [PrimaryTicketingRepUserID],
  [Status],
  [SystemStatus],
  CAST([UpdatedDateTime] AS datetime2) AS UpdatedDateTime,
  [filename],
  [loadid]
INTO [echlHeartlanders].[staging].[paciolanAccount_migration]
FROM [echlHeartlanders].[staging].[paciolanAccount]


--- accountMerge
SELECT 
      [filename] 
      ,[loadid]
      ,[MergeAccountID]
      ,[ParentAccountDbID]
      ,[ParentAccountID]
      ,CAST([UpdatedDateTime] AS datetime2) AS UpdatedDateTime
INTO [echlHeartlanders].[staging].[paciolanAccountMerge_migration]
FROM [echlHeartlanders].[staging].[paciolanAccountMerge]
  


--- addresstype
SELECT 
 [AccountID],
 [Address1],
  [Address2],
  [Address3],
  [AddressType],
  [AddressTypeCode],
  [CareOf],
  [City],
  [Country],
  [County],
  [MailName],
  [RegionID],
  [RegionName],
  [State],
  [SystemStatus],
  CAST([UpdatedDateTime] AS datetime2) AS UpdatedDateTime,
  [ZipCode],
  [filename],
  [loadid]
INTO [echlHeartlanders].[staging].[paciolanAddressType_migration]
FROM [echlHeartlanders].[staging].[paciolanAddressType]


--- barcode
SELECT 
[AccountID],
[Barcode],
[EventCode],
[ItemCode],
CAST([LastUpdate] AS datetime2) AS LastUpdate,
[Level],
[PriceLevelCode],
[PriceTypeCode],
[Row],
[ScanCluster],
CAST([ScanDateTime] AS datetime2) AS ScanDateTime,
[ScanGate],
[ScanLocation],
[ScanResponseCode],
[Scanned],
[SeasonCode],
[Seat],
[Section],
[StatusCode],
[StatusName],
[filename],
[loadid]
INTO [echlHeartlanders].[staging].[paciolanBarcode_migration]
FROM [echlHeartlanders].[staging].[paciolanBarcode]


--- billplantype
SELECT 
      [BillPlanPercentage]
      ,CAST([billplandate] AS datetime2) AS billplandate
      ,[BillPlanTypeCode]
      ,[BillPlanTypeName]
      ,CAST([LastUpdate] AS datetime2) AS LastUpdate
      ,[SeasonCode]
      ,[VMC]
      ,[loadid]
      ,[filename]
INTO [echlHeartlanders].[staging].[paciolanBillPlanType_migration]
FROM [echlHeartlanders].[staging].[paciolanBillPlanType]


--- contact
SELECT 
[AccountID]
,CAST([BirthDate] AS datetime2) AS BirthDate
,[ContactID]
,[FirstName]
,[IsPrimaryContact]
,[lastName]
,[MiddleName]
,[NickName]
,[Suffix]
,[SystemStatus]
,[Title]
,CAST([UpdatedDateTime] AS datetime2) AS UpdatedDateTime
,[filename]
,[loadid]
INTO [echlHeartlanders].[staging].[paciolanContact_migration]
FROM [echlHeartlanders].[staging].[paciolanContact]


--- email
SELECT 
[AccountID]
      ,[EmailAddress]
      ,[EmailAddrType]
      ,[EmailAddrTypeCode]
      ,[SystemStatus]
      ,CAST([UpdateDateTime] AS datetime2) AS UpdateDateTime
      ,[loadid]
      ,[filename]
INTO [echlHeartlanders].[staging].[paciolanEmail_migration]
FROM [echlHeartlanders].[staging].[paciolanEmail]


--- event
SELECT 
[BasisCode]
,[Capacity]
,[EventBasisName]
,[EventClassCode]
,[EventClassName]
,[EventCode]
,[EventConfigCode]
,[EventConfigName]
,CAST([eventdatetime] AS datetime2) AS eventdatetime
,[EventGroupCode]
,[EventGroupName]
,[EventName]
,[EventTypeCode]
,[EventTypeName]
,[FacilityCode]
,[FacilityName]
,CAST([LastUpdate] AS datetime2) AS LastUpdate
,[OrderAmt]
,[OrderQty]
,[SeasonCode]
,[SeatsAllocated]
,[SeatsComp]
,[SeatsHeld]
,[SeatsKilled]
,[SeatsPrinted]
,[SeatsRemaining]
,[filename]
,[loadid]
INTO [echlHeartlanders].[staging].[paciolanEvent_migration]
FROM [echlHeartlanders].[staging].[paciolanEvent]


--- eventorderdetail
SELECT 
[AccountId],
[BillPlanTypeCode],
[EventCode],
[EventPayAmount],
[EventPrice],
[EventQuantity],
[FacilityFeeAmount],
[FacilityFeePayAmount],
[FacilityFeePrice],
[InternetRefData],
[InternetRefSource],
[PriceLevelCode],
[PriceTypeCode],
[SEQ],
[SalcodeCode],
[SeasonCode],
[SeatBlocks],
[SurchargeAmount],
[SurchargeCode],
[SurchargePayAmount],
[TicketChargeAmount],
[TicketChargeCode],
[TicketChargeName],
[TicketChargePayAmount],
[TicketChargePrice],
[VMC],
[filename],
[loadid]
INTO [echlHeartlanders].[staging].[paciolanEventOrderDetail_migration]
FROM [echlHeartlanders].[staging].[paciolanEventOrderDetail]


--- item order detail
SELECT 
[AccountId],
[AssocAccountId],
[BillPlanTypeCode],
CAST([Date] AS datetime2) AS Date,
[DiscountAmount],
[DiscountCode],
[DiscountName],
[DispositionCode],
[DispositionName],
[EventCodes],
[FacilityFeeAmount],
[FacilityFeePayAmount],
[FacilityFeePrice],
[FirstEventSeatBlocks],
[InternetRefData],
[InternetRefSource],
[ItemCode],
[ItemPayAmount],
[ItemPrice],
[ItemQuantity],
[MarkCode],
[MarkName],
[PriceLevelCode],
[PriceTypeCode],
[PromoCode],
[PromoName],
[SEQ],
[SalcodeCode],
[SeasonCode],
[SurchargeAmount],
[SurchargeCode],
[SurchargePayAmount],
[TicketChargeAmount],
[TicketChargeCode],
[TicketChargeName],
[TicketChargePayAmount],
[TicketChargePrice],
[filename],
[loadid]
INTO [echlHeartlanders].[staging].[paciolanItemOrderDetail_migration]
FROM [echlHeartlanders].[staging].[paciolanItemOrderDetail]


--- odetdelete
SELECT 
      [AccountID]
      ,[SeasonCode]
      ,[SEQ_DEL]
      ,[loadid]
      ,[filename]
INTO [echlHeartlanders].[staging].[paciolanOdetDelete_migration]
FROM [echlHeartlanders].[staging].[paciolanOdetDelete]

--- phone
SELECT 
    [AccountID]
      ,[DoNotCall]
      ,[PhoneNumber]
      ,[PhoneType]
      ,[PhoneTypeCode]
      ,[SystemStatus]
      ,CAST([UpdateDateTime] AS datetime2) AS UpdateDateTime
      ,[loadid]
      ,[filename]
INTO [echlHeartlanders].[staging].[paciolanPhone_migration]
FROM [echlHeartlanders].[staging].[paciolanPhone]


--- pricelevel
SELECT 
      [ItemCode]
      ,CAST([LastUpdate] AS datetime2) AS LastUpdate
      ,[PriceLevelName]
      ,[PriceLevelCode]
      ,[SeasonCode]
      ,[loadid]
      ,[filename]
INTO [echlHeartlanders].[staging].[paciolanPriceLevel_migration]
FROM [echlHeartlanders].[staging].[paciolanPriceLevel]


--- season
SELECT 
      [ActivityCode]
      ,[ActivityName]
      ,CAST([LastUpdate] AS datetime2) AS LastUpdate
      ,[PrevSeasonCode]
      ,[SeasonCode]
      ,[SeasonName]
      ,[Status]
      ,[loadid]
      ,[filename]
INTO [echlHeartlanders].[staging].[paciolanSeason_migration]
FROM [echlHeartlanders].[staging].[paciolanSeason]


--- seats
SELECT 
[AccountId],
[Aisle],
[AreaCode],
[AreaName],
[Barcode],
[EventCode],
[Gate],
[ItemCode],
CAST([LastUpdate] AS datetime2) AS LastUpdate,
[Level],
[OrderDetailKey],
[PreviousSeatStatusCode],
[PriceLevelCode],
[PriceTypeCode],
[ReservedForMP],
[Row],
[SeasonCode],
[Seat],
[SeatStatusCode],
[SeatStatusName],
[Section],
[SoldPrice],
[VMC],
[filename],
[loadid]
INTO [echlHeartlanders].[staging].[paciolanSeat_migration]
FROM [echlHeartlanders].[staging].[paciolanSeat]


--- stubhub
SELECT 
      [AccountId]
      ,[EventCode]
      ,[OriginalTicketAmount]
      ,[Quantity]
      ,CAST([ResaleDate] AS datetime2) AS ResaleDate
      ,[ResaleValue]
      ,[SalecodeCode]
      ,[SeasonCode]
      ,[SeatBlock]
      ,[TransNumber]
      ,[TransType]
      ,[loadid]
      ,[filename]
INTO [echlHeartlanders].[staging].[paciolanStubhub_migration]
FROM [echlHeartlanders].[staging].[paciolanStubhub]


--- transitemevents
SELECT 
[AccountId],
[BillPlanTypeCode],
CAST([Date] AS datetime2) AS Date,
[EventAmount],
[EventCode],
[EventPayAmount],
[EventPrice],
[EventQuantity],
[FacilityFeeAmount],
[FacilityFeePayAmount],
[FacilityFeePrice],
[InternetRefData],
[InternetRefSource],
[ItemCode],
[PriceLevelCode],
[PriceTypeCode],
[SVMC],
[SalcodeCode],
[SeasonCode],
[SeatBlocks],
[SurchargeAmount],
[SurchargeCode],
[SurchargePayAmount],
[TicketChargeAmount],
[TicketChargeCode],
[TicketChargeName],
[TicketChargePayAmount],
[TicketChargePrice],
[TransActivityCode],
[TransActivityName],
[TransActivityType],
[TransNumber],
[VMC],
[filename],
[loadid]
INTO [echlHeartlanders].[staging].[paciolanTransItemEvent_migration]
FROM [echlHeartlanders].[staging].[paciolanTransItemEvent]


--- transitems

SELECT 
[AccountId],
[AssocAccountId],
[BillPlanTypeCode],
CAST([Date] AS datetime2) AS Date,
[DiscountAmount],
[DiscountCode],
[DiscountName],
[DispositionCode],
[DispositionName],
[FacilityFeeAmount],
[FacilityFeePayAmount],
[FacilityFeePrice],
[InternetRefData],
[InternetRefSource],
[ItemAmount],
[ItemCode],
[ItemPayAmount],
[ItemPrice],
[ItemQuantity],
[PriceLevelCode],
[PriceTypeCode],
[PromoCode],
[PromoName],
[SalcodeCode],
[SeasonCode],
[SurchargeAmount],
[SurchargeCode],
[SurchargePayAmount],
[TicketChargeAmount],
[TicketChargeCode],
[TicketChargeName],
[TicketChargePayAmount],
[TicketChargePrice],
[TransActivityCode],
[TransActivityName],
[TransActivityType],
[TransNumber],
[VMC],
[filename],
[loadid]
INTO [echlHeartlanders].[staging].[paciolanTransItem_migration]
FROM [echlHeartlanders].[staging].[paciolanTransItem]

---
SELECT 

INTO [echlRush].[staging].[test_migration]
FROM [echlRush].[staging].[test]


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