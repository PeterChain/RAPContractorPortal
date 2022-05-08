CLASS zcl_nager_api_holidays DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS co_nager_api    TYPE string VALUE `https://date.nager.at/api/v3/PublicHolidays/`.

    TYPES: ty_year    TYPE n LENGTH 4.

    TYPES: BEGIN OF ty_s_holidays,
             date         TYPE string,
             local_name   TYPE string,
             name         TYPE string,
             country_code TYPE string,
             fixed        TYPE abap_boolean,
             global       TYPE abap_boolean,
           END OF ty_s_holidays.

    TYPES: ty_t_holidays TYPE TABLE OF ty_s_holidays WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        i_cal_country TYPE land1.

    "! <p class="shorttext synchronized" lang="en">Returns the holidays information for a specific year</p>
    "! @parameter i_year | <p class="shorttext synchronized" lang="en">Year of reference</p>
    "! @parameter result | <p class="shorttext synchronized" lang="en">Holidays</p>
    "! @raising zcx_nager_api | <p class="shorttext synchronized" lang="en">Nager API error</p>
    METHODS get
      IMPORTING
        i_year        TYPE ty_year OPTIONAL
      RETURNING
        VALUE(result) TYPE ty_t_holidays
      RAISING
        zcx_nager_api.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA m_cal    TYPE land1.

    "! <p class="shorttext synchronized" lang="en"></p>
    "! @parameter i_response | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter result | <p class="shorttext synchronized" lang="en"></p>
    METHODS parse_response
      IMPORTING
        i_response    TYPE string
      RETURNING
        VALUE(result) TYPE zcl_nager_api_holidays=>ty_t_holidays.
ENDCLASS.



CLASS zcl_nager_api_holidays IMPLEMENTATION.
  METHOD constructor.
    m_cal = i_cal_country.
  ENDMETHOD.


  METHOD get.
    DATA(url) = |{ co_nager_api }{ i_year }/{ m_cal }/|.

    TRY.
        " Create the connection
        DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
        DATA(client) = cl_web_http_client_manager=>create_by_http_destination( dest ).
      CATCH cx_http_dest_provider_error cx_web_http_client_error.
        RAISE EXCEPTION TYPE zcx_nager_api
          MESSAGE e003(zpc_ctr_fcal).
    ENDTRY.

    TRY.
        " Calls the API
        DATA(response) = client->execute( if_web_http_client=>get )->get_text( ).

      CATCH cx_web_http_client_error cx_web_message_error.
        RAISE EXCEPTION TYPE zcx_nager_api
          MESSAGE e002(zpc_ctr_fcal).
    ENDTRY.

    result = VALUE #( FOR e IN parse_response( response )
                      ( VALUE #( BASE e
                                 date = |{ e-date(4) }{ e-date+5(2) }{ e-date+8(2) }| ) ) ).
  ENDMETHOD.


  METHOD parse_response.
    /ui2/cl_json=>deserialize( EXPORTING json        =  i_response
                                         pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                               CHANGING data         = result ).
  ENDMETHOD.

ENDCLASS.
