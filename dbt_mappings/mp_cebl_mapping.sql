ticketing_tickets_ticketmaster:

client_property: 

CASE
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'calgary')) OR LOWER(e.event_name_long) LIKE '24cs0521' THEN 'cebl_surge'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'edmonton')) THEN 'cebl_stingers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'vancouver')) THEN 'cebl_bandits'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'fraser')) THEN 'cebl_bandits'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'saskatchewan')) THEN 'cebl_rattlers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'winnipeg')) THEN 'cebl_seabears'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'montreal')) THEN 'cebl_alliance'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'ottawa')) THEN 'cebl_blackjacks'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'niagara')) THEN 'cebl_riverlions'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'scarborough')) THEN 'cebl_shootingstars'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'brampton')) THEN 'cebl_honeybadgers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') OR REGEXP_LIKE(LOWER(e.minor_category), 'other')) AND (REGEXP_LIKE(LOWER(e.org_name), 'newfoundland')) THEN 'cebl_growlers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'hamilton')) THEN 'cebl_honeybadgers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'guelph')) THEN 'cebl_nighthawks'
    ELSE 'mp_cebl'
END 

stlr_product: 

CASE
    WHEN REGEXP_LIKE(t.ticket_type, '^(?i)(.*new season.*|.*renewal season.*)') AND t.pc_ticket > 0.0 AND REGEXP_LIKE(t.price_code, '^(?i).[nr]') THEN 'Full Season'
    WHEN LOWER(t.comp_name) NOT LIKE '%not comp%' THEN 'Comp'
    WHEN REGEXP_LIKE(t.price_code, '^(?i).[nr]') THEN 'Full Season'
    WHEN REGEXP_LIKE(t.price_code, '^(?i).(3v|av)') THEN 'Mini Plan'
    WHEN REGEXP_LIKE(t.price_code, '^(?i).g') THEN 'Group'
    WHEN REGEXP_LIKE(t.price_code, '^(?i).d') THEN 'Deposit'
    WHEN REGEXP_LIKE(t.price_code, '^(?i).[s*]') THEN 'Individual'
    WHEN (REGEXP_LIKE(e.minor_category, '(?i).*basketball.*') AND REGEXP_LIKE(e.org_name, '(?i).*calgary.*')) THEN 
      CASE 
        WHEN REGEXP_LIKE(t.price_code, '^.3') THEN 'Flex Plan' 
        WHEN REGEXP_LIKE(t.price_code, '^.6') THEN 'Mini Plan' 
        ELSE 'Not Mapped'
      END
    WHEN (REGEXP_LIKE(e.minor_category, '(?i).*basketball.*') AND REGEXP_LIKE(e.org_name, '(?i).*edmonton.*')) THEN 
      CASE 
        WHEN REGEXP_LIKE(t.price_code, '^(?i)..g') THEN 'Flex Plan' 
        WHEN REGEXP_LIKE(t.price_code, '^.5') THEN 'Mini Plan' 
        WHEN REGEXP_LIKE(t.price_code, '^.0') THEN 'Individual'
        ELSE 'Not Mapped'
      END
    WHEN (REGEXP_LIKE(e.minor_category, '(?i).*basketball.*') AND REGEXP_LIKE(e.org_name, '(?i).*saskatchewan.*')) THEN 
      CASE  
        WHEN REGEXP_LIKE(t.price_code, '^.[35]') THEN 'Mini Plan' 
        ELSE 'Not Mapped'
      END
    WHEN (REGEXP_LIKE(e.minor_category, '(?i).*basketball.*') AND REGEXP_LIKE(e.org_name, '(?i).*winnipeg.*')) THEN 
      CASE 
        WHEN REGEXP_LIKE(t.price_code, '^.[126]') THEN 'Mini Plan' 
        WHEN REGEXP_LIKE(t.price_code, '^.0') THEN 'Individual' 
        ELSE 'Not Mapped'
      END
    WHEN (REGEXP_LIKE(e.minor_category, '(?i).*basketball.*') AND REGEXP_LIKE(e.org_name, '(?i).*brampton.*')) THEN 
      CASE 
        WHEN REGEXP_LIKE(t.price_code, '^.3') THEN 'Flex Plan' 
        WHEN REGEXP_LIKE(t.price_code, '^.[16]') THEN 'Mini Plan' 
        WHEN REGEXP_LIKE(t.price_code, '^(?i).y') THEN 'Individual' 
        ELSE 'Not Mapped'
      END
    WHEN (REGEXP_LIKE(e.minor_category, '(?i).*basketball.*') AND REGEXP_LIKE(e.org_name, '(?i).*ottawa.*')) THEN 
      CASE
        WHEN REGEXP_LIKE(t.price_code, '^(?i).[fri]') THEN 'Full Season' 
        WHEN REGEXP_LIKE(t.price_code, '^(?i).p') THEN 'Flex Plan' 
        WHEN REGEXP_LIKE(t.price_code, '^(?i).[gak9]') THEN 'Group' 
        ELSE 'Not Mapped'
      END
    WHEN (REGEXP_LIKE(e.minor_category, '(?i).*basketball.*') AND REGEXP_LIKE(e.org_name, '(?i).*niagara.*')) THEN 
      CASE 
        WHEN REGEXP_LIKE(t.price_code, '^.[06]') THEN 'Mini Plan' 
        ELSE 'Not Mapped'
      END
    WHEN (REGEXP_LIKE(e.minor_category, '(?i).*basketball.*') AND REGEXP_LIKE(e.org_name, '(?i).*montreal.*')) THEN 
      CASE 
        WHEN REGEXP_LIKE(t.price_code, '^.[35]') THEN 'Flex Plan' 
        WHEN REGEXP_LIKE(t.price_code, '^.0') THEN 'Mini Plan' 
        ELSE 'Not Mapped'
      END
    ELSE 'Not Mapped'
END 

stlr_reported_revenue: 

ROUND(t.pc_ticket, 2) 

stlr_season_year: 

CASE
    WHEN REGEXP_LIKE(e.event_name_long, '^21') THEN 2021
    WHEN REGEXP_LIKE(e.event_name_long, '^25') THEN 2025
    WHEN SUBSTRING(CAST(e.event_date AS VARCHAR), 1, 4) = '2024' AND LOWER(e.org_name) LIKE 'winnipeg%' THEN 2024
    ELSE season.season_year
END 

ticketing_events_ticketmaster:

client_property: 

CASE
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'calgary')) OR LOWER(e.event_name_long) LIKE '24cs0521' THEN 'cebl_surge'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'edmonton')) THEN 'cebl_stingers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'vancouver')) THEN 'cebl_bandits'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'fraser')) THEN 'cebl_bandits'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'saskatchewan')) THEN 'cebl_rattlers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'winnipeg')) THEN 'cebl_seabears'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'montreal')) THEN 'cebl_alliance'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'ottawa')) THEN 'cebl_blackjacks'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'niagara')) THEN 'cebl_riverlions'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'scarborough')) THEN 'cebl_shootingstars'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'brampton')) THEN 'cebl_honeybadgers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') OR REGEXP_LIKE(LOWER(e.minor_category), 'other')) AND (REGEXP_LIKE(LOWER(e.org_name), 'newfoundland')) THEN 'cebl_growlers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'hamilton')) THEN 'cebl_honeybadgers'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'guelph')) THEN 'cebl_nighthawks'
    ELSE 'mp_cebl'
END 

stlr_game_number: 

CASE
    WHEN e.total_events = 1 AND NOT (e.plan = 'Y' OR REGEXP_LIKE(LOWER(e.event_name_long),'(deposit|test|do not|voucher|delete|flex|pack|credit|awards|bcla|manifest|session|fiba)'))
    THEN DENSE_RANK() OVER (PARTITION BY 
        CASE
            WHEN e.total_events > 1 OR e.plan = 'Y' OR REGEXP_LIKE(LOWER(e.event_name_long),'(deposit|test|do not|voucher|delete|flex|pack|credit|awards|bcla|manifest|session|fiba)') THEN null
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'calgary')) OR LOWER(e.event_name_long) LIKE '%cs%' THEN 'cebl_surge'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'edmonton')) THEN 'cebl_stingers'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'vancouver')) THEN 'cebl_bandits'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'fraser')) THEN 'cebl_bandits'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'saskatchewan')) THEN 'cebl_rattlers'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'winnipeg')) THEN 'cebl_seabears'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'montreal')) THEN 'cebl_alliance'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'ottawa')) THEN 'cebl_blackjacks'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'niagara')) THEN 'cebl_riverlions'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'scarborough')) THEN 'cebl_shootingstars'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'brampton')) THEN 'cebl_honeybadgers'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') OR REGEXP_LIKE(LOWER(e.minor_category), 'other')) AND (REGEXP_LIKE(LOWER(e.org_name), 'newfoundland')) THEN 'cebl_growlers'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'hamilton')) THEN 'cebl_honeybadgers'
            WHEN (REGEXP_LIKE(LOWER(e.minor_category), 'basketball') AND REGEXP_LIKE(LOWER(e.org_name), 'guelph')) THEN 'cebl_nighthawks'
            ELSE null
        END,
        CASE
            WHEN REGEXP_LIKE(e.event_name_long, '^21') THEN 2021
            WHEN REGEXP_LIKE(e.event_name_long, '^25') THEN 2025
            WHEN SUBSTRING(CAST(e.event_date AS VARCHAR), 1, 4) = '2024' AND REGEXP_LIKE(LOWER(e.org_name), 'winnipeg') THEN 2024
            ELSE s.season_year
        END
        ORDER BY e.event_date, e.event_time)
    ELSE null
END 

stlr_is_renewal: 

e.plan = 'Y' AND NOT REGEXP_LIKE(LOWER(e.event_name_long),'(deposit|test|do not|voucher|delete|flex|pack|credit|awards|bcla|manifest|session|fiba)') AND NOT (LOWER(e.event_type) = 'single event') 

stlr_season_year: 

CASE
    WHEN REGEXP_LIKE(e.event_name_long, '^21') THEN 2021
    WHEN REGEXP_LIKE(e.event_name_long, '^25') THEN 2025
    WHEN SUBSTRING(CAST(e.event_date AS VARCHAR), 1, 4) = '2024' AND LOWER(e.org_name) LIKE 'winnipeg%' THEN 2024
    ELSE s.season_year
END 

