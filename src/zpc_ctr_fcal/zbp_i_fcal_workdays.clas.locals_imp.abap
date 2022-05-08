CLASS lhc_Workdays DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Workdays RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR workdays RESULT result.

    METHODS fill_from_ext_source FOR MODIFY
      IMPORTING keys FOR ACTION workdays~fill_from_ext_source.

ENDCLASS.

CLASS lhc_Workdays IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD get_instance_features.
  ENDMETHOD.


  METHOD fill_from_ext_source.
    " To the URL append the year we're refering to and the calendar country
    DATA(today) = cl_abap_context_info=>get_system_date( ).

    DATA(instance) = VALUE #( keys[ 1 ] OPTIONAL ).
    IF instance-Calendar IS INITIAL.
      APPEND VALUE #( %key              = instance-%key
                      %msg              = new_message( id       = zif_cp_cal_con=>msg_class
                                                       number   = zif_cp_cal_con=>msg_initial_cal_code
                                                       severity = if_abap_behv_message=>severity-error )
                      ) TO reported-workdays.
    ENDIF.

    TRY.
        DATA(holidays) = NEW zcl_nager_api_holidays( instance-Calendar )->get( today(4) ).
      CATCH zcx_nager_api INTO DATA(api_error).
        APPEND VALUE #( %key  = instance-%key
                        %msg  = new_message_with_text( text = api_error->get_text( ) )
                      ) TO reported-workdays.
        RETURN.
    ENDTRY.

    " Get the current holidays
    READ ENTITIES OF zi_fcal_workdays IN LOCAL MODE
      ENTITY Holidays
      ALL FIELDS WITH VALUE #( ( CalKey = instance-%key-CalKey ) )
      RESULT DATA(db_holidays).

    LOOP AT holidays INTO DATA(holiday).
      DATA(db_holiday) = VALUE #( db_holidays[ CalYear  = holiday-date(4)
                                               CalMonth = holiday-date+4(2)
                                               CalDay   = holiday-date+6(2) ] OPTIONAL ).

      " If we have an entry for the same date, then we modify it
      IF db_holiday IS NOT INITIAL.
        MODIFY ENTITIES OF zi_fcal_workdays IN LOCAL MODE
          ENTITY Holidays
          UPDATE
          SET FIELDS WITH VALUE #( ( %key = db_holiday-%key
                                     Name = holiday-local_name ) ).

      ELSE.
        MODIFY ENTITIES OF zi_fcal_workdays IN LOCAL MODE
          ENTITY Holidays
          CREATE
          SET FIELDS WITH VALUE #( ( %key-Calendar = instance-Calendar
                                     %key-CalKey   = instance-CalKey
                                     Name          = holiday-local_name
                                     CalYear       = holiday-date(4)
                                     CalMonth      = holiday-date+4(2)
                                     CalDay        = holiday-date+6(2) ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
