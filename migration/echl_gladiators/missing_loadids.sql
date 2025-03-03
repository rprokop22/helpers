select distinct loadid, 'arena_migration' as table_name
                        from staging.[arena_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'attendance_migration' as table_name
                        from staging.[attendance_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'availSeats_migration' as table_name
                        from staging.[availSeats_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'custAddress_migration' as table_name
                        from staging.[custAddress_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'custEmail_migration' as table_name
                        from staging.[custEmail_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'custRep_migration' as table_name
                        from staging.[custRep_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'customer_migration' as table_name
                        from staging.[customer_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'event_migration' as table_name
                        from staging.[event_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'journal_migration' as table_name
                        from staging.[journal_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'plans_migration' as table_name
                        from staging.[plans_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'priceCode_migration' as table_name
                        from staging.[priceCode_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'season_migration' as table_name
                        from staging.[season_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'seatManifest_migration' as table_name
                        from staging.[seatManifest_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'tex_migration' as table_name
                        from staging.[tex_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    ) UNION ALL
select distinct loadid, 'ticket_migration' as table_name
                        from staging.[ticket_migration]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like 'echlgladiators'
                    )