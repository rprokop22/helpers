DROP TABLE IF EXISTS [echlGladiators].[staging].[custaddress_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[custemail_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[customermerges_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[custrep_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[customer_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[event_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[eventsinplan_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[invlineitem_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[journal_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[paymentschedulemop_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[paymentschedulepayment_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[paymentschedule_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[plans_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[pricecode_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[promocode_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[retailevent_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[retailnonticket_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[season_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[seatmanifest_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[tex_migration];
DROP TABLE IF EXISTS [echlGladiators].[staging].[ticket_migration];

BEGIN TRANSACTION customerAddress_transaction;

with temp_cte_custAddress as (
SELECT
	[custnameid]
	,[custaddressid]
	,[addresstype]
	,[addresstypename]
	,[acctid]
	,[primaryind]
	,[streetaddr1]
	,[streetaddr2]
	,[city]
	,[STATE]
	,[zip]
	,[country]
	,[county]
	,[solicitmail]
	,[solicitmailregistry]
	,[carrierroute]
	,[seasonal]
	,[startdate]
	,[enddate]
	,[citystatezip]
	,[nameprefix]
	,[nameprefix2]
	,[namefirst]
	,[namemiddle]
	,[namelast]
	,[namesuffix]
	,[nametitle]
	,[companyname]
	,[nickname]
	,[maidenname]
	,[salutation]
	,[namelastfirstmi]
	,[fullname]
	,[primarycode]
	,[addresstypeprimaryind]
	,[nametype]
	,[ownername]
	,[ownernamefull]
	,[seqnum]
	,[loadid]
	,[filename]
FROM [echlGladiators].[staging].[customerAddress]
)
SELECT * INTO [echlGladiators].[staging].[custAddress_migration] FROM temp_cte_custAddress

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[customerAddress]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[custAddress_migration])
	BEGIN
		COMMIT TRANSACTION custAddress_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION custAddress_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION custemail_transaction;

with temp_cte_custemail as (
SELECT
	[custNameId]
	,[emailType]
	,[emailTypeName]
	,[acctId]
	,[emailAddr]
	,[primaryInd]
	,[solicitEmail]
	,[solicitEmailRegistry]
	,[emailComment]
	,[status]
	,[statusName]
	,[emailSort]
	,[emailId]
	,[seqNum]
	,[maInd]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[custemail]
)
SELECT * INTO [echlGladiators].[staging].[custemail_migration] FROM temp_cte_custemail

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[custemail]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[custemail_migration])
	BEGIN
		COMMIT TRANSACTION custemail_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION custemail_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION customermerges_transaction;

with temp_cte_customermerges as (
SELECT
	[acctId]
	,[newAcctId]
	,[updUser]
	,[updDatetime]
	,[seqNum]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[customermerges]
)
SELECT * INTO [echlGladiators].[staging].[customermerges_migration] FROM temp_cte_customermerges

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[customermerges]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[customermerges_migration])
	BEGIN
		COMMIT TRANSACTION customermerges_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION customermerges_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION customer_transaction;

with temp_cte_customer as (
SELECT
	[acctId]
	,[custNameId]
	,[relationshipType]
	,[primaryCode]
	,[recStatus]
	,[acctTypeDesc]
	,[salutation]
	,[companyName]
	,[nameFirst]
	,[nameMi]
	,[nameLast]
	,[nameTitle]
	,[streetAddr1]
	,[streetAddr2]
	,[city]
	,[state]
	,[zip]
	,[country]
	,[phoneDay]
	,[phoneEve]
	,[phoneFax]
	,[tag]
	,[acctRepNum]
	,[acctRepName]
	,[priority]
	,[points]
	,[pointsYtd]
	,[pointsItd]
	,[emailAddr]
	,[addDate]
	,[addUser]
	,[updDate]
	,[updUser]
	,[birthDate]
	,[sinceDate]
	,[oldAcctId]
	,[householdId]
	,[fanLoyaltyId]
	,[extSystem1Id]
	,[extSystem2Id]
	,[otherInfo1]
	,[otherInfo2]
	,[otherInfo3]
	,[otherInfo4]
	,[otherInfo5]
	,[otherInfo6]
	,[otherInfo7]
	,[otherInfo8]
	,[otherInfo9]
	,[otherInfo10]
	,[source]
	,[sourceName]
	,[sourceDesc]
	,[pin]
	,[gender]
	,[solicitPhoneDay]
	,[solicitPhoneEve]
	,[solicitPhoneFax]
	,[solicitEmail]
	,[solicitAddr]
	,[maritalStatus]
	,[sicCode]
	,[sicName]
	,[industry]
	,[phoneCell]
	,[solicitPhoneCell]
	,[emailAddr2]
	,[sourceListName]
	,[maidenName]
	,[nameType]
	,[otherInfo11]
	,[otherInfo12]
	,[otherInfo13]
	,[otherInfo14]
	,[otherInfo15]
	,[otherInfo16]
	,[otherInfo17]
	,[otherInfo18]
	,[otherInfo19]
	,[otherInfo20]
	,[seqNum]
	,[accountManagerAccess]
	,[adminInvoice]
	,[adminEventInfo]
	,[adminRofr]
	,[adminDonation]
	,[adminOther]
	,[accountNickName]
	,[mainAcctIdInd]
	,[pkId]
	,[filename]
	,[loadId]
	-- ,[languageName]
	-- ,[privacyRestrict]
	-- ,[privacyRestrictUpdUser]
	-- ,[privacyOptOut]
	-- ,[privacyOptOutUpdUser]
	-- ,[privacyRestrictUpdDatetime]
	-- ,[privacyOptOutUpdDatetime]
	-- ,[privacyOptOutSource]
	-- ,[maFirstName]
	-- ,[maLastName]
	-- ,[maPhone]
	-- ,[maEmail]
	-- ,[maLinkDate]
	-- ,[maLinkValue]
	-- ,[maPhoneNumber]
FROM [echlGladiators].[staging].[customer]
)
SELECT * INTO [echlGladiators].[staging].[customer_migration] FROM temp_cte_customer

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[customer]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[customer_migration])
	BEGIN
		COMMIT TRANSACTION customer_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION customer_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS [echlGladiators].[staging].[event_migration];

BEGIN TRANSACTION event_transaction;

with temp_cte_event as (
SELECT
	[eventName]
	,[eventDate]
	,[eventTime]
	,[eventDay]
	,[team]
	,[planAbv]
	,[eventReportGroup]
	,[planType]
	,[enabled]
	,[returnable]
	,[minEvents]
	,[totalEvents]
	,[fse]
	,[dspsAllowed]
	,[exchangePriceOpt]
	,[seasonName]
	,[eventNameLong]
	,[tmEventName]
	,[eventSort]
	,[gameNumber]
	,[barcodeStatus]
	,[printTicketInd]
	,[addDate]
	,[updUser]
	,[updDate]
	,[eventId]
	,[maxeventdate]
	,[eventType]
	,[arenaName]
	,[majorCategory]
	,[minorCategory]
	,[orgName]
	,[plan]
	,[seasonId]
	,[dwEventId]
	,[seqNum]
	-- ,NULL AS 'line1'
	-- ,NULL AS 'line2'
	-- ,NULL AS 'line3'
	-- ,NULL AS 'line4'
	-- ,NULL AS 'line5'
	-- ,NULL AS 'line6'
	-- ,NULL AS 'line7'
	-- ,NULL AS 'line8'
	-- ,NULL AS 'line9'
	-- ,NULL AS 'line10'
	,[filename]
	  ,[ingestion_property]
	  ,[ingestion_datetime]
	,[loadId]
FROM [echlGladiators].[staging].[event]
)
SELECT * INTO [echlGladiators].[staging].[event_migration] FROM temp_cte_event

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[event]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[event_migration])
	BEGIN
		COMMIT TRANSACTION event_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION event_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION eventsinplan_transaction;

with temp_cte_eventsinplan as (
SELECT
	[planGroupId]
	,[planGroupName]
	,[planEventId]
	,[planEventName]
	,[planTotalEvents]
	,[planType]
	,[eventId]
	,[eventName]
	,[eventDate]
	,[eventTime]
	,[team]
	,[gameNumber]
	,[totalEvents]
	,[tmEventName]
	,[childIsPlan]
	,[seasonId]
	,[seqNum]
	,[activity]
	,[updDatetime]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[eventsinplan]
)
SELECT * INTO [echlGladiators].[staging].[eventsinplan_migration] FROM temp_cte_eventsinplan

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[eventsinplan]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[eventsinplan_migration])
	BEGIN
		COMMIT TRANSACTION eventsinplan_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION eventsinplan_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION invlineitem_transaction;

with temp_cte_invlineitem as (
SELECT
	[acctId]
	,[orderNum]
	,[orderLineItem]
	,[orderLineItemSeq]
	,[invoiceId]
	,[amount]
	,[purchaseAmount]
	,[grossInvoiceAmount]
	,[invoiceMethod]
	,[itemAmount]
	,[status]
	,[requiredInd]
	,[optOut]
	,[optOutUser]
	,[optOutDatetime]
	,[seqNum]
	,[paymentScheduleId]
	,[complexKey]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[invlineitem]
)
SELECT * INTO [echlGladiators].[staging].[invlineitem_migration] FROM temp_cte_invlineitem

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[invlineitem]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[invlineitem_migration])
	BEGIN
		COMMIT TRANSACTION invlineitem_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION invlineitem_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION journal_transaction;

with temp_cte_journal as (
SELECT
	[acctId]
	,[stamp]
	,[seq]
	,[type]
	,[typeDesc]
	,[debit]
	,[credit]
	,[invoiceAmount]
	,[eventId]
	,[orderNum]
	,[orderLineItem]
	,[orderLineItemSeq]
	,[ccType]
	,[paymentTypeDesc]
	,[paymentScheduleId]
	,[invoiceId]
	,[journalSeqId]
	,[orgId]
	,[orgName]
	,[teamname]
	,[addUser]
	,[updUser]
	,[creditApplied]
	,[batchTag]
	,[batchId]
	,[ccNumMasked]
	,[surchgAmount]
	,[surchgCode]
	,[discAmount]
	,[discCode]
	,[ledgerCode]
	,[merchantCode]
	,[planEventName]
	,[eventName]
	,[sectionName]
	,[rowName]
	,[seatNum]
	,[lastSeat]
	,[sellLocation]
	,[info]
	,[postedDate]
	,[seqNum]
	,[posted]
	,[numSeats]
	,[priceCode]
	,[updDatetime]
	,[filename]
	,[ingestion_property]
	,[ingestion_datetime]
	,[loadId]
FROM [echlGladiators].[staging].[journal]
)
SELECT * INTO [echlGladiators].[staging].[journal_migration] FROM temp_cte_journal

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[journal]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[journal_migration])
	BEGIN
		COMMIT TRANSACTION journal_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION journal_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION paymentschedulemop_transaction;

with temp_cte_paymentschedulemop as (
SELECT
	[paymentScheduleId]
	,[seq]
	,[acctId]
	,[paymentPlanId]
	,[paymentPercentage]
	,[paymentCategory]
	,[ccMask]
	,[ccExp]
	,[seqNum]
	,[updDatetime]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[paymentschedulemop]
)
SELECT * INTO [echlGladiators].[staging].[paymentschedulemop_migration] FROM temp_cte_paymentschedulemop

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[paymentschedulemop]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[paymentschedulemop_migration])
	BEGIN
		COMMIT TRANSACTION paymentschedulemop_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION paymentschedulemop_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION psp_transaction;

with temp_cte_paymentschedulepayment as (
SELECT
	[paymentScheduleId]
	,[paymentNumber]
	,[dueDate]
	,[percentDue]
	,[paymentDescription]
	,[seqNum]
	,[updDatetime]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[paymentschedulepayment]
)
SELECT * INTO [echlGladiators].[staging].[paymentschedulepayment_migration] FROM temp_cte_paymentschedulepayment

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[paymentschedulepayment]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[paymentschedulepayment_migration])
	BEGIN
		COMMIT TRANSACTION psp_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION psp_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION paymentschedule_transaction;

with temp_cte_paymentschedule as (
SELECT
	[paymentScheduleId]
	,[acctId]
	,[invoiceId]
	,[paymentPlanId]
	,[comments]
	,[addUser]
	,[addTimestamp]
	,[paymentPlanName]
	,[periods]
	,[lastPeriodPaid]
	,[purchaseAmount]
	,[paidAmount]
	,[percentDue]
	,[percentPaid]
	,[compliant]
	,[invoiceDesc]
	,[effectiveDate]
	,[expirationDate]
	,[inetEffectiveDate]
	,[inetExpirationDate]
	,[inetPlanName]
	,[paymentPlanType]
	,[lastPaymentNumber]
	,[periodType]
	,[startDate]
	,[seqNum]
	,[updTimestamp]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[paymentschedule]
)
SELECT * INTO [echlGladiators].[staging].[paymentschedule_migration] FROM temp_cte_paymentschedule

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[paymentschedule]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[paymentschedule_migration])
	BEGIN
		COMMIT TRANSACTION paymentschedule_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION paymentschedule_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION plans_transaction;

with temp_cte_plans as (
SELECT
	[acctId]
	,[planEventName]
	,[parentPlanEventId]
	,[parentPlanEventName]
	,[sectionName]
	,[rowName]
	,[seatNum]
	,[numSeats]
	,[lastSeat]
	,[seatIncrement]
	,[team]
	,[seasonName]
	,[arenaName]
	,[manifestName]
	,[planAbv]
	,[eventNameLong]
	,[sectionDesc]
	,[sectionAbv]
	,[rowDesc]
	,[gate]
	,[printRowAndSeat]
	,[printSectionName]
	,[fse]
	,[eventTypeCode]
	,[eventType]
	,[expanded]
	,[seasonId]
	,[planEventId]
	,[planDatetime]
	,[sectionId]
	,[rowId]
	,[orderNum]
	,[orderLineItem]
	,[orderLineItemSeq]
	,[requestLineItem]
	,[purchaseAmount]
	,[paidAmount]
	,[owedAmount]
	,[paid]
	,[currentDue]
	,[percentPaid]
	,[classId]
	,[priceCode]
	,[origPriceCode]
	,[priceCodeDesc]
	,[priceCodeGroup]
	,[pcColor]
	,[fullPrice]
	,[compCode]
	,[compName]
	,[discCode]
	,[discAmount]
	,[surchgCode]
	,[surchgAmount]
	,[purchasePrice]
	,[planType]
	,[pricingMethod]
	,[blockFullPrice]
	,[blockPurchasePrice]
	,[printed]
	,[printedPrice]
	,[printedDatetime]
	,[transType]
	,[consignment]
	,[groupFlag]
	,[groupSalesId]
	,[addUsr]
	,[addDatetime]
	,[updUser]
	,[updDatetime]
	,[acctSeqId]
	,[acctBlkId]
	,[sellLocationId]
	,[sellLocation]
	,[sellLocationName]
	,[aisle]
	,[salesSourceId]
	,[salesSourceDate]
	,[totalEvents]
	,[soldZip]
	,[prevLocId]
	,[contractId]
	,[acctRepId]
	,[deliveryMethod]
	,[deliveryInstructions]
	,[deliveryNameFirst]
	,[deliveryNameLast]
	,[deliveryAddr1]
	,[deliveryAddr2]
	,[deliveryAddr3]
	,[deliveryCity]
	,[deliveryState]
	,[deliveryZip]
	,[deliveryCountry]
	,[deliveryPhone]
	,[deliveredDate]
	,[otherInfo1]
	,[otherInfo2]
	,[otherInfo3]
	,[otherInfo4]
	,[otherInfo5]
	,[otherInfo6]
	,[otherInfo7]
	,[otherInfo8]
	,[otherInfo9]
	,[otherInfo10]
	,[inetStatus]
	,[assocAcctId]
	,[inetPurchasePrice]
	,[tmEventName]
	,[sectionNameRight]
	,[rowNameRight]
	,[eventSort]
	,[sectionSort]
	,[rowSort]
	,[status]
	,[ticketTypeCode]
	,[ticketType]
	,[origEventId]
	,[origEventName]
	,[nameLast]
	,[companyName]
	,[renewalInd]
	,[ticketTypeCategory]
	,[cardPrintingEnabled]
	,[acctRepFullName]
	,[ledgerCode]
	,[promoCodeId]
	,[promoCode]
	,[subPlanEventId]
	,[subPlanEventName]
	,[deliveryCountryName]
	,[currentPurchasePrice]
	,[currentBlockPurchasePrice]
	,[originalPurchasePrice]
	,[originalBlockPurchasePrice]
	,[originalTotalEvents]
	,[originalFse]
	,[originalFseTotal]
	,[currentTotalEvents]
	,[currentFse]
	,[currentFseTotal]
	,[paymentPlanIds]
	,[paymentPlanName]
	,[flexPlanPurchase]
	,[ownerName]
	,[ownerNameFull]
	,[planSeqId]
	,[subPlanSeqId]
	,[originalAcctRepId]
	,[originalAcctRepFullName]
	,[privacyRestrict]
	,[privacyOptOut]
	,[privacyRestrictUpdDatetime]
	,[privacyOptOutUpdDatetime]
	,[seqNum]
	, NULL AS 'origuser'
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[plans]
)
SELECT * INTO [echlGladiators].[staging].[plans_migration] FROM temp_cte_plans

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[plans]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[plans_migration])
	BEGIN
		COMMIT TRANSACTION plans_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION plans_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION pricecode_transaction;

with temp_cte_pricecode as (
SELECT
	[seasonid]
	,[eventid]
	,[eventname]
	,[eventdate]
	,[eventtime]
	,[eventday]
	,[plantype]
	,[team]
	,[enabled]
	,[eventsellable]
	,[pcsellable]
	,[inetpcsellable]
	,[totalevents]
	,[pricecode]
	,[price]
	,[parentpricecode]
	,[tickettypecode]
	,[fullpricetickettypecode]
	,[ttcode]
	,[tickettype]
	,[tickettypedesc]
	,[tickettypecategory]
	,[compind]
	,[defaulthostofferid]
	,[tickettyperelationship]
	,[upduser]
	,[upddatetime]
	,[pricingmethod]
	,[tmpricelevel]
	,[tmtickettype]
	,[tickettemplateoverride]
	,[tickettemplate]
	,[code]
	,[pricecodegroup]
	,[pricecodedesc]
	,[pricecodeinfo1]
	,[pricecodeinfo2]
	,[pricecodeinfo3]
	,[pricecodeinfo4]
	,[pricecodeinfo5]
	,[color]
	,[printedprice]
	,[pcticket]
	,[pctax]
	,[pclicfee]
	,[pcother1]
	,[pcother2]
	,[taxratea]
	,[taxrateb]
	,[taxratec]
	,[onsaledatetime]
	,[offsaledatetime]
	,[inetonsaledatetime]
	,[inetoffsaledatetime]
	,[inetpricecodename]
	,[inetoffertext]
	,[inetfullprice]
	,[inetminticketspertran]
	,[inetmaxticketspertran]
	,[tidfamilyid]
	,[onpurchaddtoacctgroupid]
	,[tmeventname]
	,[autoaddmembershipname]
	,[requiredmembershiplist]
	,[cardtemplateoverride]
	,[cardtemplate]
	,[ledgerid]
	,[ledgercode]
	,[merchantid]
	,[merchantcode]
	,[merchantcolor]
	,[membershipreqdforpurchase]
	,[membershipidformembershipevent]
	,[membershipname]
	,[membershipexpirationdate]
	,[clubgroupenabled]
	,[seasonname]
	,[seasonyear]
	,[orgid]
	,[orgname]
	,[teamname]
	,[seqnum]
	,[loadid]
	,[filename]
FROM [echlGladiators].[staging].[pricecode]
)
SELECT * INTO [echlGladiators].[staging].[pricecode_migration] FROM temp_cte_pricecode

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[pricecode]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[pricecode_migration])
	BEGIN
		COMMIT TRANSACTION pricecode_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION pricecode_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION promocode_transaction;

with temp_cte_promocode as (
SELECT
	[promoCodeId]
	,[promoCode]
	,[promoCodeName]
	,[acctId]
	,[promoInetName]
	,[promoInetDesc]
	,[promoType]
	,[promoGroupSellFlag]
	,[promoActiveFlag]
	,[addUser]
	,[inetStartDatetime]
	,[inetEndDatetime]
	,[archticsStartDatetime]
	,[archticsEndDatetime]
	,[eventId]
	,[eventName]
	,[tmEventName]
	,[addDatetime]
	,[updDatetime]
	,[seqNum]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[promocode]
)
SELECT * INTO [echlGladiators].[staging].[promocode_migration] FROM temp_cte_promocode

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[promocode]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[promocode_migration])
	BEGIN
		COMMIT TRANSACTION promocode_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION promocode_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION retailevent_transaction;

with temp_cte_retailevent as (
SELECT
	[retailEventId]
	,[hostName]
	,[hostEventCode]
	,[hostEventId]
	,[eventDate]
	,[eventTime]
	,[attractionId]
	,[attractionName]
	,[majorCategoryId]
	,[majorCategoryName]
	,[minorCategoryId]
	,[minorCategoryName]
	,[venueId]
	,[venueName]
	,[primaryActId]
	,[primaryAct]
	,[secondaryActId]
	,[secondaryAct]
	,[seqNum]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[retailevent]
)
SELECT * INTO [echlGladiators].[staging].[retailevent_migration] FROM temp_cte_retailevent

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[retailevent]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[retailevent_migration])
	BEGIN
		COMMIT TRANSACTION retailevent_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION retailevent_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION retailnonticket_transaction;

with temp_cte_retailnonticket as (
SELECT
	[eventName]
	,[sectionName]
	,[rowName]
	,[firstSeat]
	,[lastSeat]
	,[numSeats]
	,[seatIncrement]
	,[retailSystemName]
	,[acctId]
	,[retailEventId]
	,[retailAcctNum]
	,[retailAcctAddDate]
	,[cameFromCode]
	,[retailPriceLevel]
	,[retailTicketType]
	,[retailQualifiers]
	,[retailPurchasePrice]
	,[transactionDatetime]
	,[retailOpcode]
	,[retailOperatorType]
	,[refundFlag]
	,[addUser]
	,[addDatetime]
	,[ownerName]
	,[ownerNameFull]
	,[retailEventCode]
	,[eventDate]
	,[eventTime]
	,[attractionName]
	,[majorCategoryName]
	,[minorCategoryName]
	,[venueName]
	,[primaryAct]
	,[secondaryAct]
	,[eventId]
	,[seqNum]
	,[retailFacilityFee]
	,[retailMask]
	,[retailServiceCharge]
	,[retailFaceValue]
	,[retailFaceValueTax]
	,[retailMop]
	,[retailServiceChargeTax]
	,[retailDistanceCharge]
	,[seatStateFrom]
	,[seatStateTo]
	,[seatStateBefore]
	,[ticketsPerSeat]
	,[filename]
	--   ,[ingestion_property]
	--   ,[ingestion_datetime]
	,[loadId]
FROM [echlGladiators].[staging].[retailnonticket]
)
SELECT * INTO [echlGladiators].[staging].[retailnonticket_migration] FROM temp_cte_retailnonticket

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[retailnonticket]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[retailnonticket_migration])
	BEGIN
		COMMIT TRANSACTION retailnonticket_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION retailnonticket_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION season_transaction;

with temp_cte_season as (
SELECT
	[seasonId]
	,[name]
	,[line1]
	,[line2]
	,[line3]
	,[arenaId]
	,[manifestId]
	,[addDatetime]
	,[updUser]
	,[updDatetime]
	,[seasonYear]
	,[orgId]
	,[seqNum]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[season]
)
SELECT * INTO [echlGladiators].[staging].[season_migration] FROM temp_cte_season

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[season]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[season_migration])
	BEGIN
		COMMIT TRANSACTION season_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION season_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION seatmanifest_transaction;

with temp_cte_seatmanifest as (
SELECT
	[arenaId]
	,[manifestId]
	,[sectionId]
	,[sectionName]
	,[sectionDesc]
	,[sectionType]
	,[sectionTypeName]
	,[gate]
	,[ga]
	,[rowId]
	,[rowName]
	,[rowDesc]
	,[seatNum]
	,[numSeats]
	,[lastSeat]
	,[seatIncrement]
	,[defaultClass]
	,[className]
	,[defPriceCode]
	,[tmSectionName]
	,[tmRowName]
	,[sectionInfo1]
	,[sectionInfo2]
	,[sectionInfo3]
	,[sectionInfo4]
	,[sectionInfo5]
	,[rowInfo1]
	,[rowInfo2]
	,[rowInfo3]
	,[rowInfo4]
	,[rowInfo5]
	,[manifestName]
	,[arenaName]
	,[orgId]
	,[orgName]
	,[seqNum]
	,[aisle]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[seatmanifest]
)
SELECT * INTO [echlGladiators].[staging].[seatmanifest_migration] FROM temp_cte_seatmanifest

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[seatmanifest]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[seatmanifest_migration])
	BEGIN
		COMMIT TRANSACTION seatmanifest_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION seatmanifest_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS [echlGladiators].[staging].[ticket_migration];
BEGIN TRANSACTION ticket_transaction;

with temp_cte_ticket as (
SELECT
	[eventName]
	,[sectionName]
	,[rowName]
	,[numSeats]
	,[ticketStatus]
	,[acctId]
	,[updDatetime]
	,[seqNum]
	,[blockPurchasePrice]
	,[orderNum]
	,[orderLineItem]
	,[orderLineItemSeq]
	,[info]
	,[totalEvents]
	,[priceCode]
	,[pricingMethod]
	,[compCode]
	,[compName]
	,[paid]
	,[discCode]
	,[discAmount]
	,[surchgCodeDesc]
	,[surchgAmount]
	,[groupFlag]
	,[updUser]
	,[className]
	,[sellLocation]
	,[fullPrice]
	,[purchasePrice]
	,[salesSourceName]
	,[salesSourceDate]
	,[ticketType]
	,[priceCodeDesc]
	,[eventId]
	,[planEventId]
	,[planEventName]
	,[seatNum]
	,[lastSeat]
	,[otherInfo1]
	,[otherInfo2]
	,[otherInfo3]
	,[otherInfo4]
	,[otherInfo5]
	,[otherInfo6]
	,[otherInfo7]
	,[otherInfo8]
	,[otherInfo9]
	,[otherInfo10]
	,[acctRepId]
	,[acctRepFullName]
	,[tranType]
	,[sectionId]
	,[rowId]
	,[promoCode]
	,[retailTicketType]
	,[retailQualifiers]
	,[paidAmount]
	,[owedAmount]
	,[addDatetime]
	,[addUser]
	,[renewalInd]
	,[returnReason]
	,[returnReasonDesc]
	,[expanded]
	,[deliveryMethod]
	,[deliveryMethodName]
	,[deliveryInstructions]
	,[deliveryNameFirst]
	,[deliveryNameLast]
	,[deliveryAddr1]
	,[deliveryAddr2]
	,[deliveryAddr3]
	,[deliveryCity]
	,[deliveryState]
	,[deliveryZip]
	,[deliveryZipFormatted]
	,[deliveryCountry]
	,[deliveryPhone]
	,[deliveryPhoneFormatted]
	,[deliveredDate]
	,[groupSalesName]
	,[ledgerId]
	,[pcTicket]
	,[pcTax]
	,[pcLicfee]
	,[pcOther1]
	,[pcOther2]
	,[pcOther3]
	,[pcOther4]
	,[pcOther5]
	,[pcOther6]
	,[pcOther7]
	,[pcOther8]
	,[taxRateA]
	,[taxRateB]
	,[taxRateC]
	,[origAcctRepId]
	,[ticketSeqId]
	,[retailSystemName]
	,[retailAcctNum]
	,[retailAcctAddDate]
	,[retailMask]
	,[retailPriceLevel]
	,[retailFaceValue]
	,[retailFaceValueTax]
	,[retailFacilityFee]
	,[retailServiceCharge]
	,[retailServiceChargeTax]
	,[retailDistanceCharge]
	,[returnDatetime]
	,[ticketTypeCategory]
	,[contractId]
	,[origDatetime]
	,[planDatetime]
	,[retailMop]
	,[seqId]
	,[origPriceCode]
	,[parentPlanType]
	,[priceCodeGroup]
	,[discName]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[ticket]
)
SELECT * INTO [echlGladiators].[staging].[ticket_migration] FROM temp_cte_ticket

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[ticket]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[ticket_migration])
	BEGIN
		COMMIT TRANSACTION ticket_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION ticket_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS [echlGladiators].[staging].[tex_migration];

BEGIN TRANSACTION tex_transaction;

with temp_cte_tex as (
SELECT
	[eventName]
	,[sectionName]
	,[rowName]
	,[tmEventName]
	,[tmSectionName]
	,[tmRowName]
	,[sectionNameRight]
	,[rowNameRight]
	,[eventDate]
	,[eventTime]
	,[planType]
	,[seatNum]
	,[numSeats]
	,[lastSeat]
	,[seatIncrement]
	,[eventId]
	,[sectionId]
	,[rowId]
	,[acctId]
	,[name]
	,[companyName]
	,[origPurchasePrice]
	,[orderNum]
	,[orderLineItem]
	,[orderLineItemSeq]
	,[printCount]
	,[printCountAfter]
	,[planEventId]
	,[planEventName]
	,[addDatetime]
	,[addUser]
	,[pidId]
	,[pidIdAfter]
	,[pidNumber]
	,[pidNumberAfter]
	,[inetActionCode]
	,[activity]
	,[activityName]
	,[reasonCode]
	,[reasonName]
	,[reasonDesc]
	,[fantmTranStatus]
	,[fantmMessage]
	,[forwardToEmailAddr]
	,[forwardToName]
	,[seatCodeLow]
	,[seatCodeHigh]
	,[barcodeEventSlotMin]
	,[accessControlSystemIp]
	,[accessControlSystemPort]
	,[deliveryMethod]
	,[deliveryMethodName]
	,[assocAcctId]
	,[inetFraudScoreCode]
	,[inetCcSeqNum]
	,[inetTransId]
	,[teSellerCreditAmount]
	,[teSellerFees]
	,[tePostingPrice]
	,[teBuyerFeesHidden]
	,[tePurchasePrice]
	,[teBuyerFeesNotHidden]
	,[inetDeliveryFee]
	,[inetTransactionAmount]
	,[inetSalesSourceId]
	,[inetSalesSourceName]
	,[pickupCcPresent]
	,[pickupComment]
	,[inetActionName]
	,[achId]
	,[teBuyerSalesTax]
	,[sourceTicketingSystem]
	,[postingSource]
	,[salesChannel]
	,[teOtherFees]
	,[seqId]
	,[nameType]
	,[ownerName]
	,[ownerNameFull]
	,[seasonId]
	,[seasonName]
	,[seasonYear]
	,[orgId]
	,[orgName]
	,[teamname]
	,[action]
	,[exportDatetime]
	,[seqNum]
	,[blockPurchasePrice]
	,[priceCode]
	,[resoldInd]
	,[postedBy]
	,[resaleSystem]
	,[ticketUpdDatetime] as upddatetime
	,[ticketUpdDatetime] as ticketupddatetime
	,[ticketAddDatetime]
	,[filename]
	,[loadId]
FROM [echlGladiators].[staging].[tex]
)
SELECT * INTO [echlGladiators].[staging].[tex_migration] FROM temp_cte_tex

IF (SELECT COUNT(*) FROM [echlGladiators].[staging].[tex]) = (SELECT COUNT(*) FROM [echlGladiators].[staging].[tex_migration])
	BEGIN
		COMMIT TRANSACTION tex_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION tex_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

BEGIN TRANSACTION custRep_transaction;
	BEGIN
    	COMMIT TRANSACTION custRep_transaction; PRINT 'Transaction committed successfully.';
	END
ELSE
	BEGIN
    	ROLLBACK TRANSACTION custRep_transaction; PRINT 'Transaction rolled back due to row count mismatch.';
	END