-- - question 2
--     'Primary and secondary full season Ticket Buyers for 2023' Surge description,
-- select 
--     -- count(distinct account_id) count
--     *
-- from AwsDataCatalog.integrations_mp_cebl.ticketing_tickets t
--     join AwsDataCatalog.integrations_mp_cebl.ticketing_events e on t.event_id = e.id
-- where e.stlr_season_year = 2023
--     -- and t.returned_at is null
--     and t.stlr_product = 'Full Season'
--     and e.client_property = 'cebl_surge'
--     and (t.forwards is not null OR t.resales is not null)



-- 
-- question 3
-- select 
--     count(distinct account_id) count
-- from AwsDataCatalog.integrations_mp_cebl.ticketing_tickets t
--     join AwsDataCatalog.integrations_mp_cebl.ticketing_events e on t.event_id = e.id
--     where e.stlr_season_year = 2023
--         and t.returned_at is null
--         and t.stlr_product = 'Individual'
--         and e.client_property = 'cebl_stingers'
        
-- -- 
-- -- question 4
-- SELECT
--     COUNT(distinct account_id) as ticket_count
--     -- *
-- FROM "integrations_mp_cebl"."ticketing_tickets" t
    -- INNER JOIN "integrations_mp_cebl"."ticketing_events" e
    --     ON t.event_id = e.id
    -- WHERE
    -- e.stlr_season_year IN (2023)
    -- and e.client_property = 'cebl_alliance'
    -- and CAST(e.start_date AS DATE) = CAST('2023-07-23' AS DATE)
    -- and e.id = '605'
    -- AND stlr_product = 'Individual'
    -- AND t.returned_at IS NULL

--
-- 
-- question 5
-- SELECT
--     COUNT(DISTINCT t.account_id) as total
-- FROM "integrations_mp_cebl"."ticketing_tickets" t
-- INNER JOIN "integrations_mp_cebl"."ticketing_events" e
--     ON t.event_id = e.id
-- LEFT JOIN "integrations_scv_mp_cebl"."customers_accounts" ca on t.stlr_account_id = ca.stlr_account_id AND t.source_system = ca.source_system
-- WHERE
--   e.stlr_season_year IN (2023)
--   and e.client_property = 'cebl_rattlers'
--   AND t.price_level = 'A'
--   AND t.returned_at IS NULL



-- - question 6 (NOT READY)
-- SELECT
--     COUNT(distinct account_id) count
-- FROM "integrations_mp_cebl"."ticketing_tickets" t
-- INNER JOIN "integrations_mp_cebl"."ticketing_events" e
-- ON t.event_id = e.id
-- WHERE 
-- e.client_property = 'cebl_surge'
-- 

select
    count(account_id) count
from (
    select account_id
    from (
        select e.id, t.account_id
        from AwsDataCatalog.integrations_mp_cebl.ticketing_tickets t
            join AwsDataCatalog.integrations_mp_cebl.ticketing_events e on t.event_id = e.id
        where e.stlr_season_year = 2023
            and t.returned_at is null
            and t.stlr_product = 'Individual'
            and e.client_property = 'cebl_surge'
    ) f
    group by account_id
    having count(distinct id) > 3
) g


-- --- question 7
-- select
--     count(distinct f.forwards.account_id)
-- from (
--     select e.id, t.account_id, concat_ws('|',section_name, row_name, cast(seat_num as varchar)) seat, t.forwards
--     from AwsDataCatalog.integrations_mp_cebl.ticketing_tickets t
--         join AwsDataCatalog.integrations_mp_cebl.ticketing_events e on t.event_id = e.id
--     where e.stlr_season_year = 2023 
--         and t.returned_at is null
--         and e.client_property = 'cebl_stingers' 
-- ) t
-- , unnest(forwards) f(forwards)


--- question 8
-- select
--     sum(t.stlr_reported_revenue) sum
--     -- *
-- from AwsDataCatalog.integrations_mp_cebl.ticketing_tickets t
--     join AwsDataCatalog.integrations_mp_cebl.ticketing_events e on t.event_id = e.id
-- where e.stlr_season_year = 2023
--     and t.returned_at is null
--     and t.stlr_product = 'Individual'
--     and e.client_property = 'cebl_rattlers'
--     and e.id = '565'
    