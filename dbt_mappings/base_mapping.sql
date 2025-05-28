ECHL BASE MAPPING
CASE
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)comp') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)comp') 
    OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, '') '(?i)comp') 
    OR TRY_CAST(t.block_purchase_price as int) = 0 
      THEN 'Comp'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)suite') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)suite') 
    OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, '') '(?i)suite')
      THEN 'Suite'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Full Season') THEN 'Full Season'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Half Season') THEN 'Half Season'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Mini.Plan') THEN 'Mini Plan'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Flex Plan') THEN 'Flex Plan'
  WHEN (
    REGEXP_LIKE(t.price_code_desc, '(?i)(full|season ti|STM|FS)') 
        OR REGEXP_LIKE(t.ticket_type, '(?i)(full|season ti|STM|FS)') 
        OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, ''), '(?i)(full|season ti)')
    ) AND NOT (
    REGEXP_LIKE(t.price_code_desc, '(?i)(half|mini|group|flex)') 
        OR REGEXP_LIKE(t.ticket_type, '(?i)(half|mini|group|flex)') 
        OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, ''), '(?i)(half|mini|group|flex)')
    )
      THEN 'Full Season'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)(half|HS|24 game|18 Game)') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)(half|HS|24 game|18 game)') 
    OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, ''), '(?i)half')
      THEN 'Half Season'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)(partial|quarter)') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)(partial|quarter)') 
    OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, ''), '(?i)(partial|quarter)')  
      THEN 'Partial Season'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)(six game|9 game|10 game|12 game|mini.plan|pack)') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)(six game|9 game|10 game|12 game|mini.plan|pack)') 
    OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, ''), '(?i)(six game|9 game|10 game|12 game|mini.plan|pack)')  
      THEN 'Mini Plan'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)flex') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)flex') 
    OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, '') '(?i)flex')
      THEN 'Flex Plan'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)(group|pack|FEVO|Spinzo)') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)(group|pack|FEVO|Spinzo)') 
    OR REGEXP_LIKE(coalesce(t.price_code_group, pc.price_code_group, '') '(?i)(group|pack|FEVO|Spinzo)') 
      THEN 'Group'
  WHEN REGEXP_LIKE(t.ticket_type, '(?i)Adult') 
    THEN 'Individual'
  ELSE 'Not Mapped'
END


BASE TICKETMASTER MAPPING 


CASE
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)comp') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)comp') 
    OR REGEXP_LIKE(t.price_code_group, '(?i)comp') 
    OR t.block_purchase_price = 0.00
      THEN 'Comp'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Full Season') THEN 'Full Season'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Half Season') THEN 'Half Season'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Mini.Plan') THEN 'Mini Plan'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Flex Plan') THEN 'Flex Plan'
  WHEN REGEXP_LIKE(pe.event_type, '(?i)Single Event') THEN 'Individual'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)(full|season ticket)') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)(full|season ticket)') 
      THEN 'Full Season'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)half') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)half') 
      THEN 'Half Season'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)(suite)')
      THEN 'Suite'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)(mini.plan)')
    OR REGEXP_LIKE(t.ticket_type, '(?i)(mini.plan)') 
      THEN 'Mini Plan'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)flex') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)flex') 
      THEN 'Flex Plan'
  WHEN REGEXP_LIKE(t.price_code_desc, '(?i)group') 
    OR REGEXP_LIKE(t.ticket_type, '(?i)(group|pack|FEVO|Spinzo)')
      THEN 'Group'
  WHEN REGEXP_LIKE(t.ticket_type, '(?i)(Adult)') 
      THEN 'Individual'
  ELSE 'Not Mapped'
END