# ECHL Notes

## Jacksonville Icemen

### Product mapping notes
- Flex plan in the cdp under source product show lots of half season & mini plan 
    - this looks to be mostly because the plan type is flex plan
- Suites 
    - source product of group, price code desc as loge
        - Should groups be mapped prior to suites?

## Savannah Ghost Pirates
- price codes are in multiple different products, 
    for example ![group vs full season ](image.png)
    both share the price code of GG, but only some are associated to a plan type of full season
- full seasons are odd without being able to see plan_type in the cdp
- flex also looks odd without the plan_type in the cdp

## Allen Americans
- some price codes of `CFSF`, `CHSR`, `BHSR`, `DHSR` are bucketed as full season
    - this is because the price_code_group says `Season Tickets` and plan_type is `full season`
    - some are half season where plan_type is `half season`
    - To me, the logic of price codes `.HS.` says to be Half season, but it looks like their data is inconsistent
    ![americans-full-half](americans-full-half.png)
- Single letter price codes are in many buckets
    - most often full or half season due to plan_type
    - individual if price code description and price_code_group are empty (ticket type says Base Price, or unclear)    
- Price Code `EGP1` with Group in the name is mostly of product `Group` but:
    - some have plan_types of half and full season.
- Price code `E` is hardcoded by the ai model as group. No clear reason why
    - some price code `E` tickets have group in the ticket_type, but most simply say `Base Price`. Not sure if this should be individual or Group
    
Overall, the mapping looks good, with some exceptions in Full Season. The exceptions, however, don't have high ticket counts associated with them ![Full Season Exceptions](americans-exceptions.png)

## Assumptions:
- keyword PACK is a group (as opposed to Mini or Flex plans)
- 6 game, 9 game, 12 game keywords are mini plan
- Hierarchy of product mapping is as follows:
    - Comp
    - Suite (based on ticket_type, price_code_desc, price_code_group)
    - planned events `event_type` is given highest priority on the mapping rules
    - Full
    - Half
    - Partial
    - Mini
    - Flex
    - Group
    - Individual
    - Not Mapped

    the columns hierarchy :
    - pe.event_type first,
    - followed by t.price_code_desc, t.ticket_type, t.price_code_group all of equal value