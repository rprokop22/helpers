import pandas as pd

header = 'acct_id\tcust_name_id\trelationship_type\tprimary_code\trec_status\tacct_type_desc\tsalutation\tcompany_name\tname_first\tname_mi\tname_last\tname_title\tstreet_addr_1\tstreet_addr_2\tcity\tstate\tzip\tcountry\tphone_day\tphone_eve\tphone_fax\ttag\tacct_rep_num\tacct_rep_name\tpriority\tpoints\tpoints_ytd\tpoints_itd\temail_addr\tadd_date\tadd_user\tupd_date\tupd_user\tbirth_date\tsince_date\told_acct_id\thousehold_id\tfan_loyalty_id\text_system1_id\text_system2_id\tother_info_1\tother_info_2\tother_info_3\tother_info_4\tother_info_5\tother_info_6\tother_info_7\tother_info_8\tother_info_9\tother_info_10\tsource\tsource_name\tsource_desc\tpin\tgender\tsolicit_phone_day\tsolicit_phone_eve\tsolicit_phone_fax\tsolicit_email\tsolicit_addr\tmarital_status\tsic_code\tsic_name\tindustry\tphone_cell\tsolicit_phone_cell\temail_addr2\tsource_list_name\tmaiden_name\tname_type\tother_info_11\tother_info_12\tother_info_13\tother_info_14\tother_info_15\tother_info_16\tother_info_17\tother_info_18\tother_info_19\tother_info_20\tseq_num\taccount_manager_access\tadmin_invoice\tadmin_event_info\tadmin_rofr\tadmin_donation\tadmin_other\taccount_nick_name\tmain_acct_id_ind\tpk_id\tlanguage_name\tprivacy_restrict\tprivacy_restrict_upd_user\tprivacy_opt_out\tprivacy_opt_out_upd_user\tprivacy_restrict_upd_datetime\tprivacy_opt_out_upd_datetime\tprivacy_opt_out_source\tma_first_name\tma_last_name\tma_phone\tma_email\tma_link_date\tma_link_value\tma_phone_number\trank'

# line='1\t1\t\tPrimary\tActive\tRepresentative\tJenny\t\tJenny\t\tClabaugh\t\t\t\t\t\t\tUSA\t5109862704\t\t\t\t9\tGuest Services\t\t0.00\t0.00\t0.00\tjeclabaugh@gs-warriors.com\t2002-09-03\ttm38\t2021-12-16\tTM566\t\t2002-09-03\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tA\tARCHTICS\t\t********\t\tY\t\t\tY\tY\t\t\t\t\t\t\t\t\t\tI\t\t\t\t\t\t\t\t\t\t\t7\tY\tY\tY\tY\tY\tY\t\tY\t7\t\t\t\t\t\t\t\t\tJenny\t\t\tjeclabaugh@gs-warriors.com\t2020-10-15 06:19:34.771\txiLLRw4PIo_24KOW0k9v5g'
# line='-1\t-1\t\tPrimary\tActive\tPersonal\t\t\t\t\tRetail Sale No Account\t\t\t\t\t\t\t\t\t\t\t\t9\tGuest Services\t\t0.00\t0.00\t0.00\t\t2011-06-16\tDBA\t2018-11-02\tDBA\t\t2011-01-01\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t********\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tI\t\t\t\t\t\t\t\t\t\t\t5\tY\tY\tY\tY\tY\tY\t\tY\t5\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t0'
# line='76\t90\t\tPrimary\tActive\tRepresentative\tPaul\t\tPaul\t\tRatner\t\t329 Behrens Street\tUnited States\tEl Cerrito\tCA\t94530\tUSA\t5109865413\t\t\t\t9\tGuest Services\t\t0.00\t0.00\t0.00\tpratner@warriors.com\t2005-03-11\tksbarton\t2021-04-15\taapi04\t\t2005-03-11\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tA\tARCHTICS\t\t********\t\tY\t\t\tY\tY\t\t\t\t\t\t\t\t\t\tI\t\t\t\t\t\t\t\t\t\t\t75\tY\tY\tY\tY\tY\tY\t\tY\t75\t\t\t\t\t\t\t\t\tPaul\tRatner\t(415) 336-2856\tpratner@warriors.com\t2020-10-15 17:38:10.836\tUiuOx9agEmij_Nno-OIJow\t(415) 336-2856\t'
# line='14360663\t1382931\t\tPrimary\tActive\tPersonal\tJerry\t\tJerry\t\tTrinidad\t\t46-265 Haiku Road\t\tKaneohe\tHI\t96744\tUS\t\t+18082858085\t\t\t9\tGuest Services\t\t0.00\t0.00\t0.00\tkaleo93@yahoo.com\t2017-10-18\tretail01\t2017-10-18\tretail01\t\t2017-10-18\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tI\tInternet\tCfc_rb_presents_blai\t********\t\t\tY\t\tY\tY\t\t\t\t\t8082945756\tY\t\t\t\tI\t\t\t\t\t\t\t\t\t\t\t1283396\tY\tY\tY\tY\tY\tY\t\tY\t1283396\tEnglish (US)\t\t\t\t\t\t\t\tJerry\tTrinidad\t(808) 285-8085\tkaleo93@yahoo.com\t2020-10-15 08:51:43.777\t0tTA6-gXrTK7uMTCdnF4EQ\t\t'
# line = '143\t906908\t\tPrimary\tActive\tEmployee\tMaria\t\tMaria\t\tSerrano\t\t\t\t\t\t\tUSA\t\t\t\t\t9\tGuest Services\t\t0.00\t0.00\t0.00\tmgserrano@gs-warriors.com\t2011-05-10\tCGILBERT\t2024-10-07\tDLEE\t\t2011-05-10\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tA\tARCHTICS\t\t********\t\t\t\t\tY\tY\t\t\t\t\t\t\t\t\t\tI\t\t\t\t\t\t\t\t\t\t\t139\tY\tY\tY\tY\tY\tY\t\tY\t139\t\t\t\t\t\t\t\t\tMaria\tSerrano\t\tmgserrano@gs-warriors.com\t2020-10-15 13:50:22.444\tBlJcTZcbUKYvDn67Pfv_9g'
# line='145\t839996\t\tPrimary\tActive\tRepresentative\tMary\t\tMary\t\tSmebye\t\t\t\t\t\t\tUSA\t\t\t\t\t9\tGuest Services\t\t0.00\t0.00\t0.00\t\t2009-11-16\tANGILMAN\t2012-10-16\tTM41\t\t2009-11-16\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tA\tARCHTICS\t\t********\t\t\t\t\t\tY\t\t\t\t\t\t\t\t\t\tI\t\t\t\t\t\t\t\t\t\t\t141\tY\tY\tY\tY\tY\tY\t\tY\t141'
line = '5775227\t614012\t\tPrimary\tProspect\tPersonal\tChristine\t\tChristine\tA.\tRicke\t\t3195 Gravenstein Hwy. N\t\tSebastopol\tCA\t95472-2325\tUS\t\t\t\t\t9\tGuest Services\t\t0.00\t0.00\t0.00\txinar@xinar.com\t2008-01-22\ttm35\t2008-01-22\ttm35\t\t2008-01-22\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tL\tList Import\tSmartDM\t********\tF\t\t\t\tY\tY\t\t\t\t\t\t\t\t\t\tI\t\t\t\t\t\t\t\t\t\t\t458480\tY\tY\tY\tY\tY\tY\t\tY\t458480\t\t\t\t\t\t\t\t\tChristine A Ricke\t\t\txinar@xinar.com\t2020-10-16 01:47:38.677\tToVABWZ1MpEefTOVYDjIPw\t\t'
header_length = 106
line_fields = line.split('\t')




for i in range(header_length):
    if i < len(line_fields):
        continue
    else:
        line_fields[i] = ''

if __name__ == '__main__':
    # for field in field_matches:
    #     if field == "MISSING FIELD!!!!!!!":
    #         print(field_matches[field])


