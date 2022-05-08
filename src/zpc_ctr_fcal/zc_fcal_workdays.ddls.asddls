@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View: Fact.Cal. Workdays'
define root view entity ZC_FCAL_WORKDAYS
  as projection on ZI_FCAL_WORKDAYS
{
      @UI.facet: [
        {
          id: 'Header',
          purpose: #HEADER,
          type: #HEADERINFO_REFERENCE,
          label: 'Header',
          targetQualifier: 'Header'
        },
        {
          id: 'Workdays',
          purpose: #STANDARD,
          type: #FIELDGROUP_REFERENCE,
          label: 'Workdays',
          targetQualifier: 'Workdays'
        },
        {
          id: 'Holidays',
          purpose: #STANDARD,
          type: #LINEITEM_REFERENCE,
          label: 'Holidays',
          targetElement: 'Holidays'
        }
      ]

      @UI: {
            lineItem: [{ position: 10 }],
            identification: [{ position: 10 }],
            fieldGroup: [{qualifier: 'Header'}]
          }
  key Calendar,
      @UI: {
            lineItem: [{ hidden: true }],
            identification: [{ hidden: true }],
            fieldGroup: [{qualifier: 'Header'}]
          }
  key CalKey,
      @UI: {
            lineItem: [{ position: 20 }],
            identification: [
              { position: 20, 
                type: #FOR_ACTION,
                dataAction: 'fill_from_ext_source',
                label: 'Retrieve holidays' }
            ],
            fieldGroup: [{qualifier: 'Workdays'}]
          }
      WorkMonday,
      @UI: {
        lineItem: [{ position: 30 }],
        identification: [{ position: 30 }],
        fieldGroup: [{qualifier: 'Workdays'}]
      }
      WorkTuesday,
      @UI: {
        lineItem: [{ position: 40 }],
        identification: [{ position: 40 }],
        fieldGroup: [{qualifier: 'Workdays'}]
      }
      WorkWednesday,
      @UI: {
        lineItem: [{ position: 50 }],
        identification: [{ position: 50 }],
        fieldGroup: [{qualifier: 'Workdays'}]
      }
      WorkThursday,
      @UI: {
        lineItem: [{ position: 60 }],
        identification: [{ position: 60 }],
        fieldGroup: [{qualifier: 'Workdays'}]
      }
      WorkFriday,
      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ hidden: true }]
      }
      CreatedBy,

      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ hidden: true }]
      }
      CreatedAt,

      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ hidden: true }]
      }
      LastChangedBy,

      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ hidden: true }]
      }
      LastChangedAt,

      @UI.dataFieldDefault: [{hidden: true}]
      @UI.identification: [{ hidden: true }]
      LocalLastChangedAt,

      /* Associations */
      Holidays : redirected to composition child ZC_FCAL_HOLIDAYS
}
