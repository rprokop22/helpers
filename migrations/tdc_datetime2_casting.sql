-- This set of select into queries are for the second half of the TDC tables used in the migration for a tdc team (echl in this case)
-- An issue arose with the migration of echl_walleye, and there was a need to re-cast everything as a datetime2 datatype. 
-- Ask Robbie Prokop if you have any questions

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

-- patronNote

SELECT 
[patronNoteId]
,[noteTypeId]
,[noteAssociationTypeDesc]
,[patronAccountId]
,[patronContactId]
,[noteText]
,[activeStatus]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,[createdByAgencyId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[patronNote_migration_1]
from [ToledoWalleye].[staging].[patronNote]

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

-- patronTrait

SELECT 
[patronTraitId]
,[patronContactId]
,[patronAccountId]
,[traitId]
,[integerData]
,[dateData]
,[stringData]
,[currencyData]
,[memoData]
,[booleanData]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,[createdByAgencyId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[patronTrait_migration_1]
from [ToledoWalleye].[staging].[patronTrait]

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

-- promotion

SELECT 
[promotionId]
,[promotionCode]
,[promotionDesc]
,[promotionDisplayOrder]
,[activeStatus]
,[promotionPublicDesc]
,[promotionTypeDesc]
,[supplierId]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[promotion_migration_1]
from [ToledoWalleye].[staging].[promotion]

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

-- supplier

SELECT 
[supplierId]
,[supplierCode]
,[supplierDesc]
,[supplierDisplayOrder]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[supplier_migration_1]
from [ToledoWalleye].[staging].[supplier]

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

-- trait

SELECT 
[traitId]
,[traitCode]
,[traitDesc]
,[traitDisplayOrder]
,[activeStatus]
,[traitShortDesc]
,[traitAssociationTypeDesc]
,[traitFlashTypeDesc]
,[integerPrompt]
,[datePrompt]
,[stringPrompt]
,[currencyPrompt]
,[memoPrompt]
,[booleanPrompt]
,[currencyCode]
,[labelTraitFieldTypeDesc]
,[dataTraitFieldTypeDesc]
,[traitGroupId]
,[traitGroupCode]
,[traitGroupDesc]
,[traitGroupDisplayOrder]
,[traitGroupTypeDesc]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
INTO [ToledoWalleye].[staging].[trait_migration_1]
from [ToledoWalleye].[staging].[trait]

-- user

SELECT
 [userId]
,[firstName]
,[middleName]
,[lastName]
,[formattedName]
,[userLogin]
,[activeStatus]
,CAST([createdDate] AS datetime2) AS createdDate
,[createdByUserId]
,CAST([lastUpdatedDate] AS datetime2) AS lastUpdatedDate
,[lastUpdatedByUserId]
INTO [ToledoWalleye].[staging].[user_migration_1]
from [ToledoWalleye].[staging].[user]

