CLASS lhc_Project DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Project RESULT result.

    METHODS validateRatePeriod FOR VALIDATE ON SAVE
      IMPORTING keys FOR rate~validateRatePeriod.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Project RESULT result.

    METHODS validaterateoverlap FOR VALIDATE ON SAVE
      IMPORTING keys FOR rate~validaterateoverlap.

    METHODS validateprojconsistency FOR VALIDATE ON SAVE
      IMPORTING keys FOR project~validateprojconsistency.

    METHODS validaterateconsistency FOR VALIDATE ON SAVE
      IMPORTING keys FOR rate~validaterateconsistency.

ENDCLASS.

CLASS lhc_Project IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD get_instance_features.
  ENDMETHOD.


  METHOD validateRatePeriod.
    READ ENTITIES OF zi_project IN LOCAL MODE
      ENTITY Project
      FIELDS ( FromDate ToDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_project).

    DATA(ls_project) = lt_project[ 1 ].

    READ ENTITIES OF zi_project IN LOCAL MODE
      ENTITY Rate
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_rates).

    LOOP AT lt_rates INTO DATA(ls_rate).
      IF ls_project-FromDate > ls_rate-FromDate.
        APPEND VALUE #( ProjectId = ls_rate-ProjectId
                        ToDate  = ls_rate-ToDate
                      ) TO failed-rate.
        APPEND VALUE #( %key              = ls_rate-%key
                        %element-FromDate = if_abap_behv=>mk-on
                        %msg              = new_message(
                                               id       = zif_ctr_portal_con=>core_msg_class
                                               number   = zif_ctr_portal_con=>msg_rate_prior_2_project
                                               severity = if_abap_behv_message=>severity-error )
                        ) TO reported-rate.
        EXIT.
      ENDIF.

      IF ls_project-ToDate < ls_rate-ToDate.
        APPEND VALUE #( ProjectId = ls_rate-ProjectId
                        ToDate  = ls_rate-ToDate
                      ) TO failed-rate.
        APPEND VALUE #( %key              = ls_rate-%key
                        %element-FromDate = if_abap_behv=>mk-on
                        %msg              = new_message(
                                               id       = zif_ctr_portal_con=>core_msg_class
                                               number   = zif_ctr_portal_con=>msg_rate_post_project
                                               severity = if_abap_behv_message=>severity-error )
                        ) TO reported-rate.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF ls_rate IS NOT INITIAL AND
       ls_rate-ToDate < ls_project-ToDate.
      APPEND VALUE #( ProjectId = ls_rate-ProjectId ) TO failed-project.
      APPEND VALUE #( %key    = ls_rate-%key
                      %msg    = new_message( id       = zif_ctr_portal_con=>core_msg_class
                                             number   = zif_ctr_portal_con=>msg_rate_until_proj_end
                                             severity = if_abap_behv_message=>severity-error )
                    ) TO reported-rate.
    ENDIF.
  ENDMETHOD.


  METHOD validateRateOverlap.
    DATA ls_prior_rate  TYPE STRUCTURE FOR READ RESULT zi_project\\rate.

    READ ENTITIES OF zi_project IN LOCAL MODE
      ENTITY Rate
      FIELDS ( ProjectId FromDate ToDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_rates).

    SORT lt_rates BY ToDate ASCENDING.

    LOOP AT lt_rates INTO DATA(ls_rate).
      IF sy-tabix = 1.
        ls_prior_rate = ls_rate.
        CONTINUE.
      ENDIF.

      IF ls_prior_rate-ToDate >= ls_rate-FromDate.
        APPEND VALUE #( ProjectId = ls_rate-ProjectId
                        ToDate  = ls_rate-ToDate
                      ) TO failed-rate.
        APPEND VALUE #( %key              = ls_rate-%key
                        %element-FromDate = if_abap_behv=>mk-on
                        %msg              = new_message(
                                               id       = zif_ctr_portal_con=>core_msg_class
                                               number   = zif_ctr_portal_con=>msg_rates_overlap
                                               severity = if_abap_behv_message=>severity-error )
                        ) TO reported-rate.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD validateProjConsistency.
    DATA lv_error   TYPE abap_bool.

    READ ENTITIES OF zi_project IN LOCAL MODE
      ENTITY Project
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_project).

    DATA(ls_project) = lt_project[ 1 ].

    IF ls_project-Description IS INITIAL.
      lv_error = abap_true.
      APPEND VALUE #( %key                 = ls_project-%key
                      %element-Description = if_abap_behv=>mk-on
                      %msg                 = new_message( id       = zif_ctr_portal_con=>core_msg_class
                                                          number   = zif_ctr_portal_con=>msg_descript_obligatory
                                                          severity = if_abap_behv_message=>severity-error )
                     ) TO reported-project.
    ENDIF.

    IF ls_project-ToDate IS INITIAL.
      lv_error = abap_true.
      APPEND VALUE #( %key              = ls_project-%key
                      %element-ToDate   = if_abap_behv=>mk-on
                      %msg              = new_message( id       = zif_ctr_portal_con=>core_msg_class
                                                       number   = zif_ctr_portal_con=>msg_proj_dates_obligatory
                                                       severity = if_abap_behv_message=>severity-error )
                     ) TO reported-project.
    ENDIF.

    IF ls_project-FromDate IS INITIAL.
      lv_error = abap_true.
      APPEND VALUE #( %key              = ls_project-%key
                      %element-FromDate = if_abap_behv=>mk-on
                      %msg              = new_message( id       = zif_ctr_portal_con=>core_msg_class
                                                       number   = zif_ctr_portal_con=>msg_proj_dates_obligatory
                                                       severity = if_abap_behv_message=>severity-error )
                     ) TO reported-project.
    ENDIF.

    IF ls_project-Calendar IS INITIAL.
      lv_error = abap_true.
      APPEND VALUE #( %key              = ls_project-%key
                      %element-Calendar = if_abap_behv=>mk-on
                      %msg              = new_message( id       = zif_ctr_portal_con=>core_msg_class
                                                       number   = zif_ctr_portal_con=>msg_calendar_obligatory
                                                       severity = if_abap_behv_message=>severity-error )
                     ) TO reported-project.
    ENDIF.

    IF ls_project-FromDate > ls_project-ToDate.
      lv_error = abap_true.
      APPEND VALUE #( %key              = ls_project-%key
                      %element-FromDate = if_abap_behv=>mk-on
                      %msg              = new_message( id       = zif_ctr_portal_con=>core_msg_class
                                                       number   = zif_ctr_portal_con=>msg_proj_dates_wrong
                                                       severity = if_abap_behv_message=>severity-error )
                     ) TO reported-project.
    ENDIF.

    IF lv_error = abap_true.
      APPEND VALUE #( ProjectId = ls_project-ProjectId ) TO failed-project.
    ENDIF.
  ENDMETHOD.


  METHOD validaterateconsistency.
    DATA lv_error   TYPE abap_bool.

    READ ENTITIES OF zi_project IN LOCAL MODE
      ENTITY Rate
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_rates).

    LOOP AT lt_rates INTO DATA(ls_rate).
      lv_error = abap_false.

      IF ls_rate-FromDate IS INITIAL.
        lv_error = abap_true.
        APPEND VALUE #( %key              = ls_rate-%key
                        %element-FromDate = if_abap_behv=>mk-on
                        %msg              = new_message( id       = zif_cp_cal_con=>msg_class
                                                         number   = zif_ctr_portal_con=>msg_rate_date_obligatory
                                                         severity = if_abap_behv_message=>severity-error )
                      ) TO reported-rate.
      ENDIF.

      IF ls_rate-HourlyRate IS INITIAL.
        APPEND VALUE #( %key                = ls_rate-%key
                        %element-HourlyRate = if_abap_behv=>mk-on
                        %msg                = new_message( id       = zif_ctr_portal_con=>core_msg_class
                                                           number   = zif_ctr_portal_con=>msg_hourly_rate_obligatory
                                                           severity = if_abap_behv_message=>severity-error )
                      ) TO reported-rate.
      ENDIF.

      IF lv_error = abap_true.
        APPEND VALUE #( ProjectId = ls_rate-ProjectId
                        ToDate    = ls_rate-ToDate
                      ) TO failed-rate.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
