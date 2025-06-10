use echlRush

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
INTO [echlRush].[staging].[paciolanAccount_migration]
FROM [echlRush].[staging].[paciolanAccount]


--- accountMerge
SELECT 
      [filename] 
      ,[loadid]
      ,[MergeAccountID]
      ,[ParentAccountDbID]
      ,[ParentAccountID]
      ,CAST([UpdatedDateTime] AS datetime2) AS UpdatedDateTime
INTO [echlRush].[staging].[paciolanAccountMerge_migration]
FROM [echlRush].[staging].[paciolanAccountMerge]
  


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
FROM [echlRush].[staging].[paciolanAddressType]
INTO [echlRush].[staging].[paciolanAddressType_migration]


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
FROM [echlRush].[staging].[paciolanBarcode]
INTO [echlRush].[staging].[paciolanBarcode_migration]


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
FROM [echlRush].[staging].[paciolanBillPlanType]
INTO [echlRush].[staging].[paciolanBillPlanType_migration]


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
FROM [echlRush].[staging].[paciolanContact]
INTO [echlRush].[staging].[paciolanContact_migration]


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
FROM [echlRush].[staging].[paciolanEmail]
INTO [echlRush].[staging].[paciolanEmail_migration]


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
FROM [echlRush].[staging].[paciolanEvent]
INTO [echlRush].[staging].[paciolanEvent_migration]


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
FROM [echlRush].[staging].[paciolanEventOrderDetail]
INTO [echlRush].[staging].[paciolanEventOrderDetail_migration]


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
FROM [echlRush].[staging].[paciolanItemOrderDetail]
INTO [echlRush].[staging].[paciolanItemOrderDetail_migration]


--- odetdelete
SELECT 
      [AccountID]
      ,[SeasonCode]
      ,[SEQ_DEL]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanOdetDelete]
INTO [echlRush].[staging].[paciolanOdetDelete_migration]

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
FROM [echlRush].[staging].[paciolanPhone]
INTO [echlRush].[staging].[paciolanPhone_migration]


--- pricelevel
SELECT 
      [ItemCode]
      ,CAST([LastUpdate] AS datetime2) AS LastUpdate
      ,[PriceLevelName]
      ,[PriceLevelCode]
      ,[SeasonCode]
      ,[loadid]
      ,[filename]
FROM [echlRush].[staging].[paciolanPriceLevel]
INTO [echlRush].[staging].[paciolanPriceLevel_migration]


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
FROM [echlRush].[staging].[paciolanSeason]
INTO [echlRush].[staging].[paciolanSeason_migration]


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
FROM [echlRush].[staging].[paciolanSeat]
INTO [echlRush].[staging].[paciolanSeat_migration]


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
FROM [echlRush].[staging].[paciolanStubhub]
INTO [echlRush].[staging].[paciolanStubhub_migration]


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
FROM [echlRush].[staging].[paciolanTransItemEvent]
INTO [echlRush].[staging].[paciolanTransItemEvent_migration]


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