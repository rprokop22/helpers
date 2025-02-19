use Toledo;

-- DROP TABLE [ToledoWalleye].[staging].[TRcustomerTickets_migrate];
-- DROP TABLE [ToledoWalleye].[staging].[TRcustomerTransactions_migrate];
-- DROP TABLE [ToledoWalleye].[staging].[TRevents_migrate];
-- DROP TABLE [ToledoWalleye].[staging].[TRlistPrices_migrate];
-- DROP TABLE [ToledoWalleye].[staging].[TRmanifests_migrate];
-- DROP TABLE [ToledoWalleye].[staging].[TRvenues_migrate];

--customer tickets
with tickets as (
select 
    e.BarMagCode as barcode,
    c.CustomerID as customerid,
    c.UserID as customername,
    c.EmailAddress as emailaddress,
    e.ReserveDate as eventdate,
    e.EventID as eventid,
    et.Opponent as opponent,
    et.level as level,
    et.Special as special1,
    et.special2,
    et.special3,
    et.eventtime as eventtime,
    et.SponsorID as sponsorid,
    e.TicketUsed as isactive,
    e.LastUpdate as lastupdate,
    e.SeasonPass as ispackage,
    e.TicketUsed as isscanned,
    s.PriceType as pricetype,
    e.row as row,
    e.LastUpdate as scantime,
    e.Seat as seat,
    e.SeatDesignation2 as section,
    c.City as soldlocation,
    e.VenueID as venueid,
    pt.price as ticketprice,
    (CASE WHEN s.sellID IS null then (c.CustomerID*-1) else s.sellid end) as transactionID,
    pt.description as ticketdescription,
    pt.PLU as ticketplu,
    pt.PriceCategory as pricecategory,
    pt.PriceRating as pricerating,
    111207 as loadid --this is a random load id taken from the walleye etl meta
    from onetime.walleyeCustomerTbl c 
left outer join onetime.walleyeEventSeatingTbl e 
    on e.OwnerID = c.CustomerID
left join onetime.walleyeSellTbl s
    ON e.EventId = s.EventId
    AND e.SellId = s.SellId
    AND e.SeatDesignation1= s.SeatDesignation1
    AND	e.SeatDesignation2= s.SeatDesignation2 
    AND	e.SeatDesignation3 = s.SeatDesignation3
    AND	e.SeatDesignation4 = s.SeatDesignation4
left join onetime.walleyeEventTbl et ON
    s.EventID = et.EventID
LEFT JOIN onetime.walleyePriceTbl2 pt
    ON ltrim(rtrim(pt.eventId)) = s.eventId
    AND ltrim(rtrim(pt.priceRating)) = s.priceRating
    AND ltrim(rtrim(pt.priceType)) = s.priceType
)
select * into [ToledoWalleye].[staging].[TRcustomerTickets_migrate] from tickets





-- select count(distinct customerid) from [ToledoWalleye].[staging].[TRcustomerTickets_migrate] --234497
-- SELECT COUNT(*) FROM ToledoWalleye.staging.TRcustomerTickets_migrate WHERE transactionid IS NULL --0
-- SELECT COUNT(*) FROM ToledoWalleye.staging.TRcustomerTickets_migrate WHERE transactionid IS NOT NULL --2,611,375
-- SELECT COUNT(*) FROM Toledo.onetime.walleyeSellTbl WHERE SellID IS NULL --0
-- SELECT COUNT(DISTINCT SellID) FROM Toledo.onetime.walleyeSellTbl --3,567,613
-- SELECT COUNT(SellID) FROM Toledo.onetime.walleyeSellTbl --3,567,613




use Toledo;
with transactions as (SELECT 
c.[CustomerID]
      ,c.[AccountType] as accounttype
      ,c.[UserID]
      ,c.[Prefix]
      ,c.[FirstName]
      ,c.[MiddleName]
      ,c.[LastName]
      ,c.[Suffix]
      ,c.[Address1] as addr1
      ,c.[Address2] as addr2
      ,c.[City]
      ,c.[State]
      ,c.[PostalCode] as zip
      ,c.[EmailAddress] as email
      ,c.[AccountType] as customertype
      ,c.[CorpName]
      ,c.[OwnerType]
      ,c.[OwnerID]
      ,c.[SetupOnTR]
      ,c.[PhoneNumber] as phone
      ,c.[Priviledges]
      ,c.[Address2_1]
      ,c.[Address2_2]
      ,c.[City2]
      ,c.[State2]
      ,c.[PostalCode2]
      ,c.[Address3_1]
      ,c.[Address3_2]
      ,c.[City3]
      ,c.[State3]
      ,c.[PostalCode3]
      ,c.[OldCustomerID]
      ,c.[PhoneNumber2] as phone2
      ,c.[PhoneNumber3] as phone3
      ,c.[Phone2Desc] as phonedesc2
      ,c.[Phone3Desc] as phonedesc3
      ,c.[SalesRep]
      ,c.[UserDefinedNumeric1]
      ,c.[UserDefinedNumeric2]
      ,c.[UserDefinedNumeric3]
      ,c.[UserDefinedNumeric4]
      ,c.[UserDefinedNumeric5]
      ,c.[UserDefinedAmt1]
      ,c.[UserDefinedAmt2]
      ,c.[UserDefinedAmt3]
      ,c.[UserDefinedAmt4]
      ,c.[UserDefinedAmt5]
      ,c.[UserDefinedText1]
      ,c.[UserDefinedText2]
      ,c.[UserDefinedText3]
      ,c.[UserDefinedText4]
      ,c.[UserDefinedText5]
      ,c.[Country]
      ,c.[Country2]
      ,c.[Country3]
      ,c.[UserDefinedNumeric6]
      ,c.[UserDefinedNumeric7]
      ,c.[UserDefinedNumeric8]
      ,c.[UserDefinedNumeric9]
      ,c.[UserDefinedNumeric10]
      ,c.[UserDefinedAmt6]
      ,c.[UserDefinedAmt7]
      ,c.[UserDefinedAmt8]
      ,c.[UserDefinedAmt9]
      ,c.[UserDefinedAmt10]
      ,c.[UserDefinedText6]
      ,c.[UserDefinedText7]
      ,c.[UserDefinedText8]
      ,c.[UserDefinedText9]
      ,c.[UserDefinedText10]
      ,c.[UserDefinedDate1]
      ,c.[UserDefinedDate2]
      ,c.[UserDefinedDate3]
      ,c.[UserDefinedDate4]
      ,c.[UserDefinedDate5]
      ,c.[UserDefinedDate6]
      ,c.[UserDefinedDate7]
      ,c.[UserDefinedDate8]
      ,c.[UserDefinedDate9]
      ,c.[UserDefinedDate10]
      ,c.[StateOther]
      ,c.[SalesRepID]
      ,(CASE 
            WHEN s.TransactionDate IS NOT NULL THEN s.TransactionDate 
            ELSE c.LastUpdate
        END
        ) AS  transactionDate
      ,(CASE WHEN s.sellID IS null then (c.CustomerID*-1) else s.sellid end) as transactionID
      ,c.city as transactionLocation
      ,c.[PPYTDGivingLevel]
      ,c.[PPLTDRanking]
      ,c.[PPLTDMaxRank]
      ,c.[PPLastRankingDate]
      ,c.[EmailOptOut]
      ,c.[EmailOptOutDate]
      ,c.[PhoneDesc]
      ,c.[GroupPortalAcct]
      ,c.[CustomerTypeID]
      ,c.[FacebookID]
      ,c.[PPMembershipDateRange]
      ,c.[CreateDate]
      ,c.[StateOther2]
      ,c.[StateOther3]
      ,c.[SpousePrefix]
      ,c.[SpouseFirstName]
      ,c.[SpouseMiddleName]
      ,c.[SpouseLastName]
      ,c.[SpouseSuffix]
      ,c.[TempPasswd]
      ,c.[TempPasswdExpires]
      ,c.[VendorID]
      ,c.[StripeCustomerID]
      ,c.[DOBDay]
      ,c.[DOBMonth]
      ,c.[DOBYear]
      ,e.[SponsorID]
      , c.[LastUpdate] as lastupdate
      ,111207 as loadid

from onetime.walleyeCustomerTbl c 
left join onetime.walleyeSellTbl s 
    on c.CustomerID=s.OperatorID
left join onetime.walleyeEventTbl e
    on e.EventId = s.EventId
)

select * into [ToledoWalleye].[staging].[TRcustomerTransactions_migrate] from transactions;





use Toledo;
with venues as (SELECT [VenueID]
      ,[VenueName]
      ,[Layout]
      ,[SeatDesgination1Desc] as seatdesignation1desc
      ,[SeatDesgination2Desc] as seatdesignation2desc
      ,[SeatDesgination3Desc] as seatdesignation3desc
      ,[SeatDesgination4Desc] as seatdesignation4desc
      ,[LastUpdate]
      ,[Address1]
      ,[Address2]
      ,[City]
      ,[State]
      ,[Zip]
      ,[Country]
      ,[TRCategory]
      ,[WebDesc]
      ,[VenueInfo]
      ,[ClientID]
      ,[ImageMap]
      ,[VenueURL]
      ,[VenueDirectionsURL]
      ,111207 as loadid
  FROM [Toledo].[onetime].[walleyeVenueTbl])

  select * into ToledoWalleye.staging.TRvenues_migrate from venues;





with manifests as (
    SELECT
       es.[EventID]
      ,es.[VenueID]
      ,es.[SeatDesignation1]
      ,es.[SeatDesignation2]
      ,es.[SeatDesignation3]
      ,es.[SeatDesignation4]
      ,es.[SeatDesignation2] as seatdescription 
      ,es.[Available]
      ,es.[OwnerType]
      ,es.[OwnerID]
      ,es.[SessionID]
      ,es.[ReserveDate]
      ,es.[PriceRating]
      ,es.[TypeCode]
      ,es.[BarMagCode]
      ,es.[WillCall]
      ,es.[TicketUsed]
      ,es.[ConfirmationID]
      ,es.[CanSell]
      ,es.[CanContribute]
      ,es.[SeasonPass]
      ,es.[MiniSeasonID]
      ,es.[Visitor]
      ,es.[Student]
      ,es.[SendToPrinter]
      ,es.[OwnerSeq]
      ,es.[SeatPriviledges]
      ,es.[OwnerPriviledges]
      ,es.[AutoDonate]
      ,es.[LastUpdate]
      ,es.[CanSellOnWeb]
      ,es.[HoldID]
      ,es.[HoldPrice]
      ,es.[HoldForCustomerID]
      ,es.[SellID]
      ,es.[SeasonPassID]
      ,es.[PriceType]
      ,es.[ReClassID]
      ,es.[Rating]
      ,es.[XCoord]
      ,es.[YCoord]
      ,es.[Handicapped]
      ,es.[Row]
      ,es.[Seat] as endingseat
      ,es.[Seat] as startingseat
      ,es.SeatDesignation2 as section
      ,es.[FulfillmentID]
      ,es.[CommissionType]
      ,es.[LastPrintedFrom]
      ,e.[Level]
      ,111207 as loadid
  FROM [Toledo].[onetime].[walleyeEventSeatingTbl] es
  JOIN [Toledo].[onetime].[walleyeEventTbl] e
    ON e.EventID = es.EventID 
  )

  select * into ToledoWalleye.staging.TRmanifests_migrate from manifests;


use Toledo;
with listPrices as (SELECT p.[EventID]
      ,p.[PriceRating]
      ,p.[PriceCategory]
      ,p.[PriceType]
      ,p.[PriceType] as shortdescription
      ,p.[Description] as description
      ,p.[Price]
      ,p.[ActualValue]
      ,p.[DonateValue]
      ,p.[SellOnWeb]
      ,p.[Parm1]
      ,p.[CanExchange]
      ,p.[ExchangeFor]
      ,p.[StartSellingDate]
      ,p.[EndSellingDate]
      ,p.[TicketImageOverride]
      ,p.[PLU]
      ,p.[ReferringURL]
      ,p.[WebCCFee]
      ,p.[BOCCFee]
      ,p.[MaxWebTickets]
      ,p.[ExchangeForWEB]
      ,p.[UserDefinedField]
      ,p.[HideBarCodeFlg]
      ,p.[ReqMaxTickets]
      ,p.[FeeID1]
      ,p.[FeeID2]
      ,p.[FeeID3]
      ,p.[FeeID4]
      ,p.[FeeID5]
      ,p.[Fees]
      ,p.[Taxes]
      ,p.[MinWebTickets]
      ,p.[IncrWebTickets]
      ,p.[PromoCode]
      ,p.[ListOrder]
      ,p.[ExchangedEventID]
      ,p.[ExchangedPriceRating]
      ,p.[ExchangedPriceType]
      ,p.[ReClassIDs]
      ,p.[CanTransfer]
      ,p.[LastUpdate]
      ,p.[NewRenewSales]
      ,p.[KioskCCFee]
      ,p.[SellOnKiosk]
      ,p.[LoadedValue]
      ,p.[PriceGroupID]
      ,p.[PriceGroupIDs]
      ,p.[WebCCFeeTax1]
      ,p.[BOCCFeeTax1]
      ,p.[KioskCCFeeTax1]
      ,p.[WebCCFeeTax1ID]
      ,p.[BOCCFeeTax1ID]
      ,p.[KioskCCFeeTax1ID]
      ,p.[SellOnMobile]
      ,p.[PrintAtHomeImageOverride]
      ,p.[PricePointID]
      ,p.[NTI]
      ,p.[DisplayOnMobileImageOverride]
      ,p.[PrintAtHomeMobileImage]
      ,p.[PrintAtHomeMobileImageOverride]
      ,e.EventDate
      ,e.VenueID
      ,111207 as loadid
  FROM [Toledo].[onetime].[walleyePriceTbl2] p 
  left join onetime.WalleyeEventTbl e on e.EventID = p.EventID)

select * into ToledoWalleye.staging.TRlistPrices_migrate from listPrices;




use Toledo;

with events as (SELECT [EventID]
      ,[Sport]
      ,[EventDate]
      ,[EventTime]
      ,[HomeTeam]
      ,[Opponent]
      ,[Special] as Special1
      ,[WeSellTickets]
      ,[SponsorID]
      ,[VenueID]
      ,[TicketImage]
      ,[GatesOpen]
      ,[GatesClose]
      ,[FreeFormLine1]
      ,[FreeFormLine2]
      ,[ESTAdjustment]
      ,[CurEventFlag]
      ,[WebSalesStart]
      ,[AdImageOnTicket]
      ,[GroupSeatingFlg]
      ,[UnDatedEvent]
      ,[WebSalesEnd]
      ,[GuestRequestFlg]
      ,[DefOnHoldRelHrs]
      ,[UseStudentBarCode]
      ,[GameNumber]
      ,[AdImageOnStudentTicket]
      ,[CheckStudentEligibility]
      ,[LastUpdate]
      ,[Special2]
      ,[Special3]
      ,[NonBAMEvent]
      ,[StudentAllSeatingFlag]
      ,[StudentSelectASeatFlag]
      ,[PriceGroupID]
      ,[SpecialNoWeb]
      ,[Special2NoWeb]
      ,[Special3NoWeb]
      ,[SearchPhrase]
      ,[PrintAtHomeImage]
      ,[ExcludeForTexting]
      ,[DisplayOnMobileImage]
      ,[DualPrinterCode]
      ,[GateValidationOnly]
      ,[Level]
      ,[PaidAdvertisement]
      ,[PaidAdvertisementText]
      ,111207 as loadid
  FROM [Toledo].[onetime].[walleyeEventTbl])

  select * into ToledoWalleye.staging.TRevents_migrate from events;