-- This set of select into queries are for the second half of the TDC tables used in the migration for a tdc team (echl in this case)
-- An issue arose with the migration of echl_walleye, and there was a need to re-cast everything as a datetime2 datatype. 
-- Ask Robbie Prokop if you have any questions


-- buyerType
SELECT 
 [buyerTypeId]
,[buyerTypeCode]
,[buyerTypeDesc]
,[buyerTypeDisplayOrder]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
,[buyerTypeGroupId]
,[buyerTypeGroupCode]
,[buyerTypeGroupDesc]
,[buyerTypeGroupDisplayOrder]
INTO [ToledoWalleye].[staging].[buyerType_migration_1]
from [ToledoWalleye].[staging].[buyerType]


-- event
SELECT 
 [eventId]
,[supplierId]
,[eventCode]
,[eventDesc]
,[eventPublicDesc]
,[eventDisplayOrder]
,[eventClassDesc]
,[eventTrueTypeDesc]
,[eventDateTypeDesc]
,[eventStatusDesc]
,[eventInventoryTypeDesc]
,[activeStatus]
,[secondaryTitle]
,[venueId]
,[venueCode]
,[venueDesc]
,[venueDisplayOrder]
,[seasonId]
,[seasonCode]
,[seasonDesc]
,[seasonDisplayOrder]
,[eventRunId]
,[eventRunCode]
,[eventRunDesc]
,[eventRunDisplayOrder]
,[targetRevenueAmount]
,[targetTicketQuantity]
,[eventDate]
,[eventDayOfWeek]
,[expansionPending]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
,[eventCategoryId]
,[eventCategoryCode]
,[eventCategoryDesc]
,[eventCategoryDisplayOrder]
INTO [ToledoWalleye].[staging].[event_migration_1]
from [ToledoWalleye].[staging].[event]


-- orders
SELECT 
 [orderId]
,[financialAccountId]
,[supplierId]
,[marketingSourceId]
,[marketType]
,[orderSalesBalance]
,[orderPaidAmount]
,[orderReservationAmount]
,[orderSalesAmount]
,[orderTotalAmount]
,[serviceChargeAmount]
,[ticketChargeAmount]
,[deliveryChargeAmount]
,[transactionChargeAmount]
,[eventChargeAmount]
,[packageChargeAmount]
,[packageSeatChargeAmount]
,[createdByChannelId]
,[createdByChannelDesc]
,[createdByChannelCode]
,[serviceRepId]
,[salesRepId]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,[createdByAgencyId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[orders_migration_1]
from [ToledoWalleye].[staging].[orders]

-- package
SELECT 
 [packageId]
,[supplierId]
,[packageCode]
,[packageDesc]
,[packageDisplayOrder]
,[activeStatus]
,[packagePublicDesc]
,[packageReferenceDate]
,[packageClassDesc]
,[seasonId]
,[seasonCode]
,[seasonDesc]
,[seasonDisplayOrder]
,[seriesId]
,[seriesCode]
,[seriesDesc]
,[seriesDisplayOrder]
,[packageGroupId]
,[packageGroupCode]
,[packageGroupDesc]
,[packageGroupDisplayOrder]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[package_migration_1]
from [ToledoWalleye].[staging].[package]

-- patron accounts
SELECT [patronAccountId]
      ,[alternateAccountId]
      ,[patronAccountName]
      ,[patronAccountTypeCode]
      ,[patronAccountTypeDesc]
      ,[activeStatus]
      ,CAST([createdDate] AS datetime2) AS createdDate
      ,[createdByUserId]
      ,[createdByAgencyId]
      ,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
      ,[lastUpdatedByUserId]
      ,[lastUpdatedByAgencyId]
      ,[loadId]
 INTO [ToledoWalleye].[staging].[patronAccount_migration_1]
FROM [ToledoWalleye].[staging].[patronAccount]

-- patronContactAddress
SELECT 
 [patronAccountId]
,[patronContactAddressId]
,[patronContactId]
,[address1]
,[address2]
,[addressTypeCode]
,[addressTypeDesc]
,[city]
,[countryCode]
,[countryName]
,[postalCode]
,[subCountryCode]
,[subCountryName]
,[isPrimaryAddress]
,[isPrimaryBillingAddress]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,[createdByAgencyId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[patronContactAddress_migration_1]
FROM [ToledoWalleye].[staging].[patronContactAddress]


-- patronContactEmail

SELECT 
[patronAccountId]
,[patronContactEmailId]
,[patronContactId]
,[patronEmailTypeCode]
,[patronEmailTypeDesc]
,[email]
,[isPrimaryBilling]
,[isPrimaryEmail]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,[createdByAgencyId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[patronContactEmail_migration_1]
from [ToledoWalleye].[staging].[patronContactEmail]

-- patronContactPhone

SELECT 
[patronAccountId]
,[patronContactId]
,[patronContactPhoneId]
,[patronPhoneTypeCode]
,[patronPhoneTypeDesc]
,[phoneDisplay]
,[phoneNumber]
,[countryCode]
,[countryName]
,[extension]
,[isPrimaryPhone]
,[isSecondaryPhone]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,[createdByAgencyId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
,[isMobile]
INTO [ToledoWalleye].[staging].[patronContactPhone_migration_1]
from [ToledoWalleye].[staging].[patronContactPhone]

-- patronContact

SELECT 
[patronContactId]
,[patronAccountId]
,[activeStatus]
,[patronContactTypeCode]
,[patronContactTypeDesc]
,[dateOfBirth]
,[firstName]
,[formattedName]
,[isPrimaryContact]
,[lastName]
,[middleName]
,[namePrefixCode]
,[namePrefixDesc]
,[nameSuffixCode]
,[nameSuffixDesc]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,[createdByAgencyId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[patronContact_migration_1]
from [ToledoWalleye].[staging].[patronContact]

-- patronSalesRep

SELECT 
[accountSalesRepId]
,[patronAccountId]
,[salesRepId]
,[agencyId]
,[salesType]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[patronSalesRep_migration_1]
from [ToledoWalleye].[staging].[patronSalesRep]

-- priceScale

SELECT 
[priceScaleId]
,[priceScaleCode]
,[priceScaleDesc]
,[priceScaleDisplayOrder]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
,[priceScaleGroupId]
,[priceScaleGroupCode]
,[priceScaleGroupDesc]
,[priceScaleGrpDisplayOrder]
INTO [ToledoWalleye].[staging].[priceScale_migration_1]
from [ToledoWalleye].[staging].[priceScale]


-- salesRep

SELECT 
[salesRepId]
,[activeStatus]
,[salesRepDisplayOrder]
,[firstName]
,[middleName]
,[lastName]
,[formattedName]
,[formalSalutation]
,[informalSalutation]
,[namePrefixCode]
,[namePrefixDesc]
,[nameSuffixCode]
,[nameSuffixDesc]
,[salesRepSubgroupId]
,[salesRepSubgroupCode]
,[salesRepSubgroupDesc]
,[salesRepSubgroupDisplayOrd]
,[salesRepGroupId]
,[salesRepGroupCode]
,[salesRepGroupDesc]
,[salesRepGroupDisplayOrder]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
INTO [ToledoWalleye].[staging].[salesRep_migration_1]
from [ToledoWalleye].[staging].[salesRep]

-- section

SELECT 
[sectionId]
,[sectionCode]
,[sectionDesc]
,[sectionDisplayOrder]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
,[sectionGroupId]
,[sectionGroupCode]
,[sectionGroupDesc]
,[sectionGroupDisplayOrder]
,[venueId]
,[venueCode]
,[venueDesc]
,[venueDisplayOrder]
INTO [ToledoWalleye].[staging].[section_migration_1]
from [ToledoWalleye].[staging].[section]

-- ticketActivity

SELECT 
[ticketId]
,[orderLineItemId]
,[transactionId]
,[marketType]
,[action]
,[changeInTicketQty]
,[transactionTypeDesc]
,[eventId]
,[usageEventId]
,[channelId]
,[channelCode]
,[channelDesc]
,[agencyId]
,[userId]
,[orderId]
,[buyerTypeId]
,[packageId]
,[packageLineId]
,[priceScaleId]
,[sectionId]
,[row]
,[seat]
,[deliveryMethodId]
,[attendingPatronId]
,[registeredPatronId]
,[scanStatus]
,[scanDate]
,[printStatus]
,[expandedStatusDesc]
,[promotionId]
,[ticketPrice]
,[ticketBasePrice]
,[saleTypeDesc]
,[transactionDate]
,[removeTransactionDate]
,[removeTransactionId]
,[marketStatus]
,[originalTicketId]
INTO [ToledoWalleye].[staging].[ticketActivity_migration_1]
from [ToledoWalleye].[staging].[ticketActivity]
