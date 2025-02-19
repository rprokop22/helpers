use ToledoWalleye
-- DROP TABLE [ToledoWalleye].[staging].[patronSalesRep_migration_2]
-- DROP TABLE [ToledoWalleye].[staging].[priceScale_migration_2]

-- DROP TABLE [ToledoWalleye].[staging].[orders_migration_2]
-- DROP TABLE [ToledoWalleye].[staging].[patronContactAddress_migration_2]
-- DROP TABLE [ToledoWalleye].[staging].[patronContactEmail_migration_2]
-- DROP TABLE [ToledoWalleye].[staging].[patronContactPhone_migration_2]
-- DROP TABLE [ToledoWalleye].[staging].[patronContact_migration_2]
-- DROP TABLE [ToledoWalleye].[staging].[patronSalesRep_migration_2]

-- -- DROP TABLE [ToledoWalleye].[staging].[salesRep_migration_2]
-- DROP TABLE [ToledoWalleye].[staging].[section_migration_2]

-- SELECT distinct loadid FROM [ToledoWalleye].[staging].[patronSalesRep]
-- WHERE loadid not in (
--                         select distinct loadid from ETLmeta.log.etlloads 
--                         where databasename like 'ToledoWalleye'
--                         and tablename like '%patronSalesRep%'
--                     )



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
,[loadId]
INTO [ToledoWalleye].[staging].[buyerType_migration_2]
from [ToledoWalleye].[staging].[buyerType]
WHERE loadId IN (1870309,1872065,1872147,1873900,1873969,1872213,1871371,1872683,1872812,1872937,1873173,1873249,1873560,1872088,1872749,1869987,1870019,1869200,1870946,1871006,1869385,1869428,1870282,1870362,1873269,1872578,1872612,1872661,1869741,1869800,1871401,1871457,1871492,1875013,1875068,1875264,1870790,1870822,1870867,1874324,1869659,1869713,1873204,1870205,1870229,1874992,1873517,1873733,1873766,1873816,1873841,1874355,1874678,1874713,1874908,1874933,1871755,1873335,1873406,1870439,1874094,1874130,1872339,1872373,1870888,1874432,1874412,1874494,1874565,1872979,1875137,1870563,1870600,1871174,1871135,1871619,1871788,1872017,1871982,1869265,1875297,1875490,1869627,1869867,1871553)

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
,[loadId]
INTO [ToledoWalleye].[staging].[event_migration_2]
from [ToledoWalleye].[staging].[event]
WHERE loadId IN (1871553,1869627,1869659,1869867,1871491,1875490,1875299,1869265,1872019,1871981,1871622,1871175,1871136,1870598,1875135,1872977,1869987,1870020,1874561,1874492,1874433,1874412,1872373,1870888,1872338,1874130,1874093,1870438,1871789,1873335,1871758,1874904,1874933,1874681,1874711,1874325,1873839,1873817,1873736,1873765,1873520,1873558,1874992,1873176,1873204,1869740,1869714,1874355,1870868,1870823,1870793,1875264,1870565,1875070,1875015,1871455,1869799,1872660,1872576,1872612,1873270,1870362,1869386,1869429,1871006,1870943,1869198,1872088,1872683,1873405,1873249,1872936,1872812,1872749,1871369,1871400,1872212,1873969,1873903,1872065,1872147,1870309,1870285,1870208,1870230)

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
,[lastUpdatedByAgencyId]
,[loadId]
INTO [ToledoWalleye].[staging].[orders_migration_2]
from [ToledoWalleye].[staging].[orders]
WHERE loadId IN (1871622,1870282,1870309,1873900,1872147,1873970,1872215,1871369,1872747,1872683,1872812,1872937,1873249,1873175,1873336,1873558,1872088,1869201,1869985,1870944,1870888,1871008,1869390,1869266,1869427,1870363,1873268,1872578,1869799,1872661,1871456,1869867,1871402,1871492,1874988,1875014,1872979,1875068,1870564,1875265,1870791,1870869,1870823,1874355,1869659,1869716,1869739,1873205,1870205,1870230,1873520,1873733,1873815,1873763,1873841,1874679,1874327,1874712,1874935,1874908,1871755,1873404,1870439,1874129,1874093,1872336,1872372,1874412,1874433,1874491,1874564,1870019,1875137,1870599,1872612,1871135,1871177,1871788,1871982,1872018,1872066,1875298,1875493,1869629,1871553)

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
,[loadId]
INTO [ToledoWalleye].[staging].[package_migration_2]
from [ToledoWalleye].[staging].[package]
WHERE loadId IN (1871554,1869629,1869869,1869658,1871491,1875493,1875299,1875265,1869268,1872018,1871982,1871789,1871135,1871175,1871007,1869426,1872661,1872612,1870599,1870021,1872976,1869986,1874494,1874565,1874432,1874412,1870888,1872370,1874129,1874095,1870438,1873406,1871757,1874935,1874906,1874679,1874713,1874325,1874355,1873839,1873763,1873818,1873733,1873520,1870208,1873205,1869712,1870867,1870821,1870791,1875068,1870564,1875015,1874988,1875135,1871400,1871456,1869740,1869799,1873269,1872576,1873249,1870365,1869387,1870945,1869198,1872088,1873559,1873336,1873175,1872937,1872683,1872813,1872747,1871371,1872337,1872216,1872148,1873969,1873900,1872066,1870285,1870308,1871624,1870229)

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
 INTO [ToledoWalleye].[staging].[patronAccount_migration_2]
FROM [ToledoWalleye].[staging].[patronAccount]
WHERE loadId IN (1870308,1872088,1873899,1872148,1872066,1873967,1872214,1871369,1872659,1872976,1872937,1872683,1872813,1873175,1873336,1873269,1873558,1870019,1872749,1869198,1870945,1871006,1869386,1869429,1870364,1873250,1870284,1872576,1869799,1871489,1871454,1875069,1874989,1875138,1870564,1875263,1875297,1870790,1870823,1870867,1874355,1869738,1869713,1873205,1870204,1875015,1870230,1873518,1873763,1873815,1873733,1873841,1874325,1874678,1874905,1874711,1874933,1873403,1871756,1870438,1874094,1872372,1872338,1874133,1870888,1874412,1874433,1874566,1874495,1869987,1872612,1870600,1871136,1871177,1871789,1871622,1871401,1872019,1871983,1869265,1875492,1869627,1869871,1869660,1871553)

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
,[lastUpdatedByAgencyId]
,[loadId]
INTO [ToledoWalleye].[staging].[patronContactAddress_migration_2]
FROM [ToledoWalleye].[staging].[patronContactAddress]
WHERE loadId IN (1871621,1870308,1870285,1872088,1872147,1873899,1873969,1872214,1871369,1872661,1872747,1872937,1872976,1872813,1873205,1870022,1869198,1870944,1869428,1869387,1874563,1873270,1873250,1870364,1872578,1872613,1869800,1871400,1871491,1875067,1875136,1874991,1875015,1875298,1875265,1870822,1870790,1870869,1869628,1869660,1869738,1869714,1872683,1873176,1870206,1873558,1873517,1870229,1873736,1873763,1873815,1873841,1874355,1874324,1874679,1874904,1874712,1873404,1873337,1874933,1871755,1874095,1870438,1874130,1872336,1874412,1870888,1872373,1874433,1874493,1870564,1869986,1871136,1871006,1870600,1871456,1871788,1871174,1872018,1872067,1869266,1871981,1875492,1869871,1871554)


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
,[lastUpdatedByAgencyId]
,[loadId]
INTO [ToledoWalleye].[staging].[patronContactEmail_migration_2]
from [ToledoWalleye].[staging].[patronContactEmail]
WHERE loadId IN (1871554,1869870,1869658,1869630,1875492,1869266,1871983,1872019,1871174,1871371,1871619,1870564,1871136,1870599,1874491,1874564,1874433,1870888,1874413,1872339,1874131,1872373,1870439,1873407,1874097,1871787,1873337,1874906,1874933,1871755,1874713,1874679,1874324,1873817,1873839,1873736,1873561,1873764,1875014,1873518,1870207,1873205,1873174,1869713,1874355,1870867,1870821,1870790,1875298,1875134,1875263,1874988,1872935,1875069,1869739,1871489,1871456,1869799,1872661,1872577,1872612,1870364,1873270,1869427,1869201,1870946,1871006,1869386,1870021,1869986,1873249,1872683,1872812,1872978,1872748,1871400,1872215,1873901,1873969,1872147,1872067,1872088,1870310,1870283,1870229)

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
,[lastUpdatedByAgencyId]
,[isMobile]
,[loadId]
INTO [ToledoWalleye].[staging].[patronContactPhone_migration_2]
from [ToledoWalleye].[staging].[patronContactPhone]
WHERE loadId IN (1870229,1871621,1870282,1872088,1870309,1872147,1873969,1873901,1872337,1872212,1871369,1872683,1872979,1872938,1872814,1873172,1873558,1873335,1869201,1870020,1869386,1870945,1871006,1869429,1873269,1873250,1870364,1872577,1872611,1869799,1872661,1871455,1871400,1869713,1869738,1875069,1872750,1873733,1875014,1875137,1875297,1875265,1870791,1870821,1870867,1870888,1873204,1870204,1873518,1874990,1873766,1873817,1873842,1874325,1874681,1874357,1874935,1874905,1874711,1871788,1871755,1870439,1873406,1872371,1874095,1874129,1874411,1874434,1874492,1874564,1870564,1869985,1870598,1871982,1871174,1871136,1869268,1872067,1872017,1875493,1869630,1869658,1869868,1871552,1871490)

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
,[lastUpdatedByAgencyId]
,[loadId]
INTO [ToledoWalleye].[staging].[patronContact_migration_2]
from [ToledoWalleye].[staging].[patronContact]
WHERE loadId IN (1869660,1871553,1871457,1875490,1869265,1871985,1872065,1872019,1871178,1869429,1871134,1869986,1870563,1870599,1874491,1874432,1874566,1874412,1874130,1872338,1872370,1874094,1870438,1871758,1871788,1873403,1873335,1874905,1874935,1874713,1874355,1874681,1874324,1873842,1873816,1873764,1873734,1874992,1875015,1873518,1873560,1870207,1873205,1873172,1869627,1869715,1870869,1870793,1875264,1870821,1875298,1875069,1872976,1875134,1871491,1869867,1871400,1869799,1869738,1872578,1872659,1872613,1870285,1870367,1873249,1873269,1869389,1871006,1870888,1870945,1870020,1869200,1872749,1872088,1872937,1872813,1872683,1871369,1872214,1873969,1873899,1872148,1870308,1870228,1871620)


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
,CAST(NULL as VARCHAR(255)) as lastUpdatedByAgencyId 
,[loadId]
INTO [ToledoWalleye].[staging].[patronSalesRep_migration_2]
from [ToledoWalleye].[staging].[patronSalesRep]
WHERE loadId IN (968365,964189,951545,955364,981212,981444,1089112,962312,966239,1852174,1083883,964450,1084109,957240,1065309,966741,1083689,980984,955578,957046,953574,1063421,1063595,968608,966475,962084,951719)

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
,[loadId]
INTO [ToledoWalleye].[staging].[priceScale_migration_2]
FROM [ToledoWalleye].[staging].[priceScale]
WHERE loadId IN (1870283,1873899,1872148,1870309,1873969,1872337,1872215,1871400,1871369,1872661,1872683,1872979,1872935,1872813,1872748,1873174,1873205,1872088,1869197,1871006,1870945,1869429,1869388,1874566,1870365,1873249,1872575,1872613,1873270,1869800,1871456,1869865,1871491,1869738,1869714,1875069,1875138,1870867,1870821,1870790,1869658,1874325,1870205,1873521,1873561,1874989,1874934,1870230,1875013,1873818,1873736,1873763,1873840,1874356,1874711,1874679,1874907,1873338,1871789,1871756,1870438,1874093,1874129,1873407,1872370,1870888,1874413,1874433,1874492,1870021,1869987,1871136,1870564,1870600,1871621,1871984,1871176,1872067,1872018,1869265,1875267,1875297,1875493,1869629,1871553,99)

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
,[loadId]
INTO [ToledoWalleye].[staging].[salesRep_migration_2]
from [ToledoWalleye].[staging].[salesRep]
WHERE loadId IN (1871553,1869870,1871489,1869627,1875490,1869265,1872019,1871985,1871176,1871620,1870600,1872613,1872660,1871138,1869986,1870019,1870564,1874493,1874433,1874413,1872372,1872339,1874134,1873407,1870438,1874095,1871788,1871756,1874934,1874905,1874711,1874679,1874356,1874325,1873815,1873840,1873558,1873733,1873765,1874988,1873519,1870208,1870230,1873206,1869713,1869738,1869658,1870791,1875299,1870821,1870868,1875135,1875068,1875014,1875263,1871456,1869799,1873269,1872575,1870362,1870284,1874565,1869426,1871006,1870944,1869386,1870889,1869199,1872683,1872749,1873249,1873173,1873336,1872937,1872976,1872812,1871372,1871400,1872216,1873969,1872147,1872088,1872066,1873900,1870309)

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
,[loadId]
INTO [ToledoWalleye].[staging].[section_migration_2]
from [ToledoWalleye].[staging].[section]
WHERE loadID IN (1870282,1870230,1871619,1873902,1872088,1872147,1872216,1873969,1871370,1872812,1872750,1872938,1873172,1873249,1872683,1870021,1869199,1869988,1870888,1870944,1871006,1869388,1870363,1870309,1872577,1873271,1872613,1872658,1869799,1869740,1871457,1875071,1875134,1875301,1875265,1872976,1874990,1870869,1870823,1870791,1869714,1870204,1873205,1873560,1873516,1875014,1873765,1873736,1873815,1873840,1874324,1874681,1874356,1874711,1874907,1874935,1871788,1871756,1873335,1874094,1870437,1873404,1874130,1872338,1872370,1874433,1874412,1874491,1874566,1870600,1869429,1870564,1871400,1871176,1871135,1871984,1872066,1872020,1875492,1869266,1871491,1869868,1869628,1869659,1871553,100)

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
,[loadId]
INTO [ToledoWalleye].[staging].[ticketActivity_migration_2]
from [ToledoWalleye].[staging].[ticketActivity]
WHERE loadId IN (1871553,1869660,1869629,1869870,1875490,1869265,1872018,1871400,1871178,1871983,1871134,1870597,1870563,1870020,1869986,1872976,1874565,1874493,1874434,1874412,1870888,1872371,1874094,1872339,1873407,1870437,1874129,1873335,1871789,1871756,1874934,1874711,1874905,1874357,1874680,1874327,1873840,1873765,1873735,1873815,1875014,1874990,1873517,1870229,1873204,1873173,1869713,1870822,1870792,1870867,1869738,1875069,1875264,1875299,1875138,1871489,1869799,1871456,1872661,1872612,1872577,1870362,1873268,1869426,1871006,1869387,1870944,1869200,1873249,1873558,1872936,1872813,1872748,1872683,1871370,1872215,1872147,1873969,1872065,1872088,1873902,1871619,1870206,1870307,1870285)