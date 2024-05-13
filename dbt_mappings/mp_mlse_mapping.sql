ticketing_tickets_ticketmaster:

client_property: 

CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN 'gleague_905'
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN 'nba_raptors'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN 'ahl_marlies'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN 'nhl_leafs'
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN 'cfl_argos'
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN 'mls_tfc'
    ELSE 'mlse_live'
    END 

stlr_product: 

CASE
    WHEN LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%raptors%' THEN 
    CASE
    WHEN (t.comp_code) in (42, 58, 67) OR LOWER(t.price_code) LIKE '3' OR LOWER(t.price_code) LIKE '_3%' OR LOWER(t.price_code) LIKE '_a%' OR LOWER(t.price_code) LIKE '_s%' THEN  'Suite'
    WHEN (t.comp_code) <> 0 THEN  'Comp'
    WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
    WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
    WHEN LOWER(t.price_code) LIKE '_h%' THEN  'Half Season'
    WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
    WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
    WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' THEN  'Individual'
    WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
    ELSE 'Not Mapped'
    END
    WHEN LOWER(e.minor_category) LIKE '%hockey%' AND LOWER(e.season_name) LIKE '%leaf%' THEN 
    CASE
    WHEN (t.comp_code) in (42, 58, 67) OR LOWER(t.price_code) LIKE '3%' OR LOWER(t.price_code) LIKE '5%' OR LOWER(t.price_code) LIKE '_a%' OR LOWER(t.price_code) LIKE '_s%' THEN  'Suite'
    WHEN (t.comp_code) <> 0 THEN  'Comp'
    WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
    WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
    WHEN LOWER(t.price_code) LIKE '_h%' THEN  'Half Season'
    WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
    WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
    WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
    WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
    ELSE 'Not Mapped'
    END
    WHEN LOWER(e.minor_category) LIKE '%soccer%' AND lower (e.season_name) LIKE '%fc%' THEN 
    CASE
    WHEN LOWER(t.price_code) LIKE '8%' OR LOWER(t.price_code) LIKE 's%' OR LOWER(t.price_code) LIKE 'y%' THEN  'Suite'
    WHEN (t.comp_code) <> 0 THEN  'Comp'
    WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
    WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
    WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
    WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LOWER(t.price_code) LIKE '_b%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
    WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
    ELSE 'Not Mapped'
    END
    ELSE 'Not Mapped'
    END 

stlr_reported_revenue: 

CASE
	WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN null
	WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44
	WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN null
	WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44
	WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN null
	WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN ROUND(t.pc_ticket, 2)
	ELSE null
END 

stlr_season_year: 

season.season_year 

ticketing_events_ticketmaster:

client_property: 

CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN 'gleague_905'
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN 'nba_raptors'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN 'ahl_marlies'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN 'nhl_leafs'
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN 'cfl_argos'
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN 'mls_tfc'
    ELSE 'mlse_live'
    END 

stlr_game_number: 

e.game_number 

stlr_is_renewal: 

e.plan = 'Y' 

stlr_season_year: 

s.season_year 

retail_orders_shopify:

client_property: 

'Other' 

retail_products_shopify:

client_property: 

case
    when (lower(tags) like '%905%' or lower(title) like '%905%') then 'gleague_905'
    when (lower(tags) like '%raptors%' or lower(title) like '%raptors%') then 'nba_raptors'
    when (lower(tags) like '%leafs%' or lower(title) like '%leafs%') then 'nhl_leafs'
    when (lower(tags) like '%toronto fc%' or lower(title) like '%toronto fc%') then 'mls_tfc'
    when (lower(tags) like '%marlies%' or lower(title) like '%marlies%') then 'ahl_marlies'
    when (lower(tags) like '%argo%' or lower(title) like '%argo%') then 'cfl_argos'
    else 'Other'
    end  







--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






CASE
    WHEN (t.comp_code) <> 0 THEN 'Comp'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[rtn]') THEN 'Full Season'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.p') THEN 'Partial Plan'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.h') THEN 'Half Season'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.m') THEN 'Mini Plan'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.f') THEN 'Flex Plan'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[x*v]') THEN 'Individual'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.g') THEN 'Group'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*raptors.*'))
        CASE
            WHEN (t.comp_code) in (42, 58, 67) OR REGEXP_LIKE(LOWER(t.price_code), '^3$|^.[3as]') THEN 'Suite'
            ELSE 'Not Mapped'
        END
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*leaf.*')) THEN 
        CASE
            WHEN (t.comp_code) in (42, 58, 67) OR REGEXP_LIKE(LOWER(t.price_code), '^[35]|^.[as]') THEN 'Suite'
            WHEN LENGTH(TRIM(t.price_code)) = 1 THEN 'Individual'
            ELSE 'Not Mapped'
        END
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*soccer.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*fc.*')) THEN 
        CASE
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^[8sy]') THEN 'Suite'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.b') OR LENGTH(TRIM(t.price_code)) = 1 THEN 'Individual'
            ELSE 'Not Mapped'
        END
    ELSE 'Not Mapped'
END


---- team specific version
CASE
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*raptors.*'))
        CASE
            WHEN (t.comp_code) <> 0 THEN 'Comp'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[rtn]') THEN 'Full Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.p') THEN 'Partial Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.h') THEN 'Half Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.m') THEN 'Mini Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.f') THEN 'Flex Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[x*v]') THEN 'Individual'
            WHEN (t.comp_code) in (42, 58, 67) OR REGEXP_LIKE(LOWER(t.price_code), '^3$|^.[3as]') THEN 'Suite'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.g') THEN 'Group'
            ELSE 'Not Mapped'
        END
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*leaf.*')) THEN 
        CASE
            WHEN (t.comp_code) <> 0 THEN 'Comp'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[rtn]') THEN 'Full Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.p') THEN 'Partial Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.h') THEN 'Half Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.m') THEN 'Mini Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.f') THEN 'Flex Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[x*v]') OR LENGTH(TRIM(t.price_code)) = 1 THEN 'Individual'
            WHEN (t.comp_code) in (42, 58, 67) OR REGEXP_LIKE(LOWER(t.price_code), '^[35]|^.[as]') THEN 'Suite'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.g') THEN 'Group'
            ELSE 'Not Mapped'
        END
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*soccer.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*fc.*')) THEN 
        CASE
            WHEN (t.comp_code) <> 0 THEN 'Comp'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[rtn]') THEN 'Full Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.p') THEN 'Partial Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.h') THEN 'Half Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.m') THEN 'Mini Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.f') THEN 'Flex Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[x*vb]') OR LENGTH(TRIM(t.price_code)) = 1 THEN 'Individual'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^[8sy]') THEN 'Suite'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.g') THEN 'Group'
            ELSE 'Not Mapped'
        END
    ELSE 'Not Mapped'
END

-- original
CASE
    WHEN LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%raptors%' THEN 
        CASE
            WHEN (t.comp_code) in (42, 58, 67) OR LOWER(t.price_code) LIKE '3' OR LOWER(t.price_code) LIKE '_3%' OR LOWER(t.price_code) LIKE '_a%' OR LOWER(t.price_code) LIKE '_s%' THEN  'Suite'
            WHEN (t.comp_code) <> 0 THEN  'Comp'
            WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
            WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
            WHEN LOWER(t.price_code) LIKE '_h%' THEN  'Half Season'
            WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
            WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
            WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' THEN  'Individual'
            WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
            ELSE 'Not Mapped'
        END
    WHEN LOWER(e.minor_category) LIKE '%hockey%' AND LOWER(e.season_name) LIKE '%leaf%' THEN 
        CASE
            WHEN (t.comp_code) in (42, 58, 67) OR LOWER(t.price_code) LIKE '3%' OR LOWER(t.price_code) LIKE '5%' OR LOWER(t.price_code) LIKE '_a%' OR LOWER(t.price_code) LIKE '_s%' THEN  'Suite'
            WHEN (t.comp_code) <> 0 THEN  'Comp'
            WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
            WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
            WHEN LOWER(t.price_code) LIKE '_h%' THEN  'Half Season'
            WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
            WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
            WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
            WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
            ELSE 'Not Mapped'
        END
    WHEN LOWER(e.minor_category) LIKE '%soccer%' AND lower (e.season_name) LIKE '%fc%' THEN 
        CASE
            WHEN LOWER(t.price_code) LIKE '8%' OR LOWER(t.price_code) LIKE 's%' OR LOWER(t.price_code) LIKE 'y%' THEN  'Suite'
            WHEN (t.comp_code) <> 0 THEN  'Comp'
            WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
            WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
            WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
            WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LOWER(t.price_code) LIKE '_b%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
            WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
            ELSE 'Not Mapped'
        END
    ELSE 'Not Mapped'
END

--- stlr_reported_revenue

-- updated march 15 2024

CASE
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*905.*')) THEN null
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*raptors.*')) THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*marlies.*')) THEN null
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*leaf.*')) THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*football.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*argo.*')) THEN null
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*soccer.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*fc.*')) THEN ROUND(t.pc_ticket, 2)
    ELSE null
END

-- original
CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN null
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN null
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN null
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN ROUND(t.pc_ticket, 2)
    ELSE null
END
-- CASE\n    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN null\n    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44\n    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN null\n    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44\n    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN null\n    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN ROUND(t.pc_ticket, 2)\n    ELSE null\nEND

----- Events Client Property

-- updated march 15 2024
CASE
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*905.*')) THEN 'gleague_905'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*raptors.*')) THEN 'nba_raptors'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*marlies.*')) THEN 'ahl_marlies'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*leaf.*')) THEN 'nhl_leafs'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*football.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*argo.*')) THEN 'cfl_argos'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*soccer.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*fc.*')) THEN 'mls_tfc'
    ELSE 'mlse_live'
END

-- original 
CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN 'gleague_905'
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN 'nba_raptors'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN 'ahl_marlies'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN 'nhl_leafs'
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN 'cfl_argos'
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN 'mls_tfc'
    ELSE 'mlse_live'
END
ticketing_tickets_ticketmaster:

client_property: 

CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN 'gleague_905'
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN 'nba_raptors'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN 'ahl_marlies'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN 'nhl_leafs'
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN 'cfl_argos'
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN 'mls_tfc'
    ELSE 'Other'
    END 

stlr_product: 

CASE
    WHEN LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%raptors%' THEN 
    CASE
        WHEN (t.comp_code) in (42, 58, 67) OR LOWER(t.price_code) LIKE '3' OR LOWER(t.price_code) LIKE '_3%' OR LOWER(t.price_code) LIKE '_a%' OR LOWER(t.price_code) LIKE '_s%' THEN  'Suite'
        WHEN (t.comp_code) <> 0 THEN  'Comp'
        WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
        WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
        WHEN LOWER(t.price_code) LIKE '_h%' THEN  'Half Season'
        WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
        WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
        WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' THEN  'Individual'
        WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
        ELSE 'Not Mapped'
    END
    WHEN LOWER(e.minor_category) LIKE '%hockey%' AND LOWER(e.season_name) LIKE '%leaf%' THEN 
    CASE
        WHEN (t.comp_code) in (42, 58, 67) OR LOWER(t.price_code) LIKE '3%' OR LOWER(t.price_code) LIKE '5%' OR LOWER(t.price_code) LIKE '_a%' OR LOWER(t.price_code) LIKE '_s%' THEN  'Suite'
        WHEN (t.comp_code) <> 0 THEN  'Comp'
        WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
        WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
        WHEN LOWER(t.price_code) LIKE '_h%' THEN  'Half Season'
        WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
        WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
        WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
        WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
        ELSE 'Not Mapped'
    END
    WHEN LOWER(e.minor_category) LIKE '%soccer%' AND lower (e.season_name) LIKE '%fc%' THEN 
    CASE
        WHEN LOWER(t.price_code) LIKE '8%' OR LOWER(t.price_code) LIKE 's%' OR LOWER(t.price_code) LIKE 'y%' THEN  'Suite'
        WHEN (t.comp_code) <> 0 THEN  'Comp'
        WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
        WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
        WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
        WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LOWER(t.price_code) LIKE '_b%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
        WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
        ELSE 'Not Mapped'
    END
    WHEN LOWER(e.minor_category) LIKE '%football%' AND lower (e.season_name) LIKE '%argo%' THEN
    CASE
        WHEN LOWER(t.price_code) LIKE '8%' OR LOWER(t.price_code) LIKE 's%' OR LOWER(t.price_code) LIKE 'y%' THEN  'Suite'
        WHEN (t.comp_code) <> 0 THEN  'Comp'
        WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
        WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
        WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
        WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
        WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
        WHEN LOWER(t.price_code) LIKE '_g%' OR LOWER(t.price_code) LIKE '_c%' THEN  'Group'
        ELSE 'Not Mapped'
    END
    ELSE 'Not Mapped'
END 

stlr_reported_revenue: 

CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN ROUND(t.pc_ticket, 2) 
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN ROUND(t.pc_ticket, 2) 
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN ROUND(t.pc_ticket, 2)
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN ROUND(t.pc_ticket, 2)
    ELSE ROUND(t.pc_ticket, 2) 
END 

stlr_season_year: 

season.season_year 

ticketing_events_ticketmaster:

client_property: 

CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN 'gleague_905'
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN 'nba_raptors'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN 'ahl_marlies'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN 'nhl_leafs'
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN 'cfl_argos'
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN 'mls_tfc'
    ELSE 'Other'
    END 

stlr_game_number: 

e.game_number 

stlr_is_renewal: 

e.plan = 'Y' 

stlr_season_year: 

s.season_year 

retail_orders_shopify:

client_property: 

'Other' 

retail_products_shopify:

client_property: 

case
    when (lower(tags) like '%905%' or lower(title) like '%905%') then 'gleague_905'
    when (lower(tags) like '%raptors%' or lower(title) like '%raptors%') then 'nba_raptors'
    when (lower(tags) like '%leafs%' or lower(title) like '%leafs%') then 'nhl_leafs'
    when (lower(tags) like '%toronto fc%' or lower(title) like '%toronto fc%') then 'mls_tfc'
    when (lower(tags) like '%marlies%' or lower(title) like '%marlies%') then 'ahl_marlies'
    when (lower(tags) like '%argo%' or lower(title) like '%argo%') then 'cfl_argos'
    else 'Other'
    end  





CASE
    WHEN (t.comp_code) <> 0 THEN 'Comp'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[rtn]') THEN 'Full Season'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.p') THEN 'Partial Plan'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.h') THEN 'Half Season'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.m') THEN 'Mini Plan'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.f') THEN 'Flex Plan'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[x*v]') THEN 'Individual'
    WHEN REGEXP_LIKE(LOWER(t.price_code), '^.g') THEN 'Group'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*raptors.*'))
        CASE
            WHEN (t.comp_code) in (42, 58, 67) OR REGEXP_LIKE(LOWER(t.price_code), '^3$|^.[3as]') THEN 'Suite'
            ELSE 'Not Mapped'
        END
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*leaf.*')) THEN 
        CASE
            WHEN (t.comp_code) in (42, 58, 67) OR REGEXP_LIKE(LOWER(t.price_code), '^[35]|^.[as]') THEN 'Suite'
            WHEN LENGTH(TRIM(t.price_code)) = 1 THEN 'Individual'
            ELSE 'Not Mapped'
        END
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*soccer.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*fc.*')) THEN 
        CASE
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^[8sy]') THEN 'Suite'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.b') OR LENGTH(TRIM(t.price_code)) = 1 THEN 'Individual'
            ELSE 'Not Mapped'
        END
    ELSE 'Not Mapped'
END


---- team specific version
CASE
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*raptors.*'))
        CASE
            WHEN (t.comp_code) <> 0 THEN 'Comp'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[rtn]') THEN 'Full Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.p') THEN 'Partial Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.h') THEN 'Half Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.m') THEN 'Mini Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.f') THEN 'Flex Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[x*v]') THEN 'Individual'
            WHEN (t.comp_code) in (42, 58, 67) OR REGEXP_LIKE(LOWER(t.price_code), '^3$|^.[3as]') THEN 'Suite'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.g') THEN 'Group'
            ELSE 'Not Mapped'
        END
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*leaf.*')) THEN 
        CASE
            WHEN (t.comp_code) <> 0 THEN 'Comp'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[rtn]') THEN 'Full Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.p') THEN 'Partial Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.h') THEN 'Half Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.m') THEN 'Mini Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.f') THEN 'Flex Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[x*v]') OR LENGTH(TRIM(t.price_code)) = 1 THEN 'Individual'
            WHEN (t.comp_code) in (42, 58, 67) OR REGEXP_LIKE(LOWER(t.price_code), '^[35]|^.[as]') THEN 'Suite'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.g') THEN 'Group'
            ELSE 'Not Mapped'
        END
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*soccer.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*fc.*')) THEN 
        CASE
            WHEN (t.comp_code) <> 0 THEN 'Comp'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[rtn]') THEN 'Full Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.p') THEN 'Partial Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.h') THEN 'Half Season'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.m') THEN 'Mini Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.f') THEN 'Flex Plan'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.[x*vb]') OR LENGTH(TRIM(t.price_code)) = 1 THEN 'Individual'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^[8sy]') THEN 'Suite'
            WHEN REGEXP_LIKE(LOWER(t.price_code), '^.g') THEN 'Group'
            ELSE 'Not Mapped'
        END
    ELSE 'Not Mapped'
END

-- original
CASE
    WHEN LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%raptors%' THEN 
        CASE
            WHEN (t.comp_code) in (42, 58, 67) OR LOWER(t.price_code) LIKE '3' OR LOWER(t.price_code) LIKE '_3%' OR LOWER(t.price_code) LIKE '_a%' OR LOWER(t.price_code) LIKE '_s%' THEN  'Suite'
            WHEN (t.comp_code) <> 0 THEN  'Comp'
            WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
            WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
            WHEN LOWER(t.price_code) LIKE '_h%' THEN  'Half Season'
            WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
            WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
            WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' THEN  'Individual'
            WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
            ELSE 'Not Mapped'
        END
    WHEN LOWER(e.minor_category) LIKE '%hockey%' AND LOWER(e.season_name) LIKE '%leaf%' THEN 
        CASE
            WHEN (t.comp_code) in (42, 58, 67) OR LOWER(t.price_code) LIKE '3%' OR LOWER(t.price_code) LIKE '5%' OR LOWER(t.price_code) LIKE '_a%' OR LOWER(t.price_code) LIKE '_s%' THEN  'Suite'
            WHEN (t.comp_code) <> 0 THEN  'Comp'
            WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
            WHEN LOWER(t.price_code) LIKE '_p%' THEN  'Partial Plan'
            WHEN LOWER(t.price_code) LIKE '_h%' THEN  'Half Season'
            WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
            WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
            WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
            WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
            ELSE 'Not Mapped'
        END
    WHEN LOWER(e.minor_category) LIKE '%soccer%' AND lower (e.season_name) LIKE '%fc%' THEN 
        CASE
            WHEN LOWER(t.price_code) LIKE '8%' OR LOWER(t.price_code) LIKE 's%' OR LOWER(t.price_code) LIKE 'y%' THEN  'Suite'
            WHEN (t.comp_code) <> 0 THEN  'Comp'
            WHEN LOWER(t.price_code) LIKE '_r%' OR LOWER(t.price_code) LIKE '_t%' OR LOWER(t.price_code) LIKE '_n%' THEN  'Full Season'
            WHEN LOWER(t.price_code) LIKE '_m%' THEN  'Mini Plan'
            WHEN LOWER(t.price_code) LIKE '_f%' THEN  'Flex Plan'
            WHEN LOWER(t.price_code) LIKE '_x%' OR LOWER(t.price_code) LIKE '_*%' OR LOWER(t.price_code) LIKE '_v%' OR LOWER(t.price_code) LIKE '_b%' OR LENGTH(TRIM(t.price_code)) = 1 THEN  'Individual'
            WHEN LOWER(t.price_code) LIKE '_g%' THEN  'Group'
            ELSE 'Not Mapped'
        END
    ELSE 'Not Mapped'
END

--- stlr_reported_revenue

-- updated march 15 2024

CASE
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*905.*')) THEN null
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*raptors.*')) THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*marlies.*')) THEN null
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*leaf.*')) THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*football.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*argo.*')) THEN null
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*soccer.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*fc.*')) THEN ROUND(t.pc_ticket, 2)
    ELSE null
END

-- original
CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN null
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN null
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN null
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN ROUND(t.pc_ticket, 2)
    ELSE null
END
-- CASE\n    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN null\n    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44\n    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN null\n    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN ROUND(t.purchase_price/1.13, 2) - 0.44\n    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN null\n    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN ROUND(t.pc_ticket, 2)\n    ELSE null\nEND

----- Events Client Property

-- updated march 15 2024
CASE
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*905.*')) THEN 'gleague_905'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*basketball.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*raptors.*')) THEN 'nba_raptors'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*marlies.*')) THEN 'ahl_marlies'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*hockey.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*leaf.*')) THEN 'nhl_leafs'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*football.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*argo.*')) THEN 'cfl_argos'
    WHEN (REGEXP_LIKE(LOWER(e.minor_category), '.*soccer.*') AND REGEXP_LIKE(LOWER(e.season_name), '.*fc.*')) THEN 'mls_tfc'
    ELSE 'mlse_live'
END

-- original 
CASE
    WHEN (LOWER(e.minor_category) LIKE '%basketball%' AND LOWER(e.season_name) LIKE '%905%') THEN 'gleague_905'
    WHEN (LOWER(e.minor_category)) LIKE '%basketball%' AND LOWER (e.season_name) LIKE '%raptors%' THEN 'nba_raptors'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%marlies%' THEN 'ahl_marlies'
    WHEN (LOWER(e.minor_category)) LIKE '%hockey%' AND LOWER (e.season_name) LIKE '%leaf%' THEN 'nhl_leafs'
    WHEN (LOWER(e.minor_category)) LIKE '%football%' AND LOWER (e.season_name) LIKE '%argo%' THEN 'cfl_argos'
    WHEN (LOWER(e.minor_category)) LIKE '%soccer%' AND LOWER (e.season_name) LIKE '%fc%' THEN 'mls_tfc'
    ELSE 'mlse_live'
END
