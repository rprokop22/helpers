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