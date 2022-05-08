INTERFACE zif_ctr_portal_con
  PUBLIC .

  CONSTANTS core_msg_class TYPE symsgid VALUE 'ZPC_CTR_CORE'.


  CONSTANTS msg_rates_overlap           TYPE symsgno VALUE 001.
  CONSTANTS msg_rate_prior_2_project    TYPE symsgno VALUE 002.
  CONSTANTS msg_rate_post_project       TYPE symsgno VALUE 003.
  CONSTANTS msg_descript_obligatory     TYPE symsgno VALUE 004.
  CONSTANTS msg_proj_dates_obligatory   TYPE symsgno VALUE 005.
  CONSTANTS msg_proj_dates_wrong        TYPE symsgno VALUE 006.
  CONSTANTS msg_calendar_obligatory     TYPE symsgno VALUE 007.
  CONSTANTS msg_rate_date_obligatory    TYPE symsgno VALUE 008.
  CONSTANTS msg_hourly_rate_obligatory  TYPE symsgno VALUE 009.
  CONSTANTS msg_rate_until_proj_end     TYPE symsgno VALUE 010.

ENDINTERFACE.
