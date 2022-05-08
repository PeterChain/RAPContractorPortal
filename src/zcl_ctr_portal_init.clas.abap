CLASS zcl_ctr_portal_init DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CTR_PORTAL_INIT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lt_project_types   TYPE TABLE OF ztproj_type.

    lt_project_types = VALUE #( ( type  = 'C'
                                  descr = 'Consultancy' )
                                ( type  = 'P'
                                  descr = 'Product' ) ).

    MODIFY ztproj_type FROM TABLE @lt_project_types.
  ENDMETHOD.
ENDCLASS.
