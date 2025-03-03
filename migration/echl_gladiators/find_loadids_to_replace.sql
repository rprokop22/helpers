select distinct top 1 loadid, 'arena_migration' as table_name
                        from staging.[arena_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'attendance_migration' as table_name
                        from staging.[attendance_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'availSeats_migration' as table_name
                        from staging.[availSeats_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'custAddress_migration' as table_name
                        from staging.[custAddress_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'custEmail_migration' as table_name
                        from staging.[custEmail_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'custRep_migration' as table_name
                        from staging.[custRep_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'customer_migration' as table_name
                        from staging.[customer_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'event_migration' as table_name
                        from staging.[event_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'journal_migration' as table_name
                        from staging.[journal_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'plans_migration' as table_name
                        from staging.[plans_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'priceCode_migration' as table_name
                        from staging.[priceCode_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'season_migration' as table_name
                        from staging.[season_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'seatManifest_migration' as table_name
                        from staging.[seatManifest_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'tex_migration' as table_name
                        from staging.[tex_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct top 1 loadid, 'ticket_migration' as table_name
                        from staging.[ticket_migration]
                        where loadid in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    )