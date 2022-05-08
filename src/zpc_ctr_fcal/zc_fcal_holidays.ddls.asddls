@EndUserText.label: 'Consumption View: Fact.Cal. Holidays'
@AccessControl.authorizationCheck: #CHECK
define view entity ZC_FCAL_HOLIDAYS
  as projection on ZI_FCAL_HOLIDAYS
{
      @UI.facet: [
        {
          id: 'Holiday',
          purpose: #STANDARD,
          type: #FIELDGROUP_REFERENCE,
          label: 'Holidays',
          targetQualifier: 'Holiday'
        }
      ]
      @UI: {
        identification: [{ position: 10 }],
        lineItem: [{ position: 10 }],
        fieldGroup: [{qualifier: 'Holiday'}]
      }
  key Calendar,
      @UI: {
        identification: [{ hidden: true }],
        lineItem: [{ hidden: true }],
        fieldGroup: [{qualifier: 'Holiday'}]
      }
  key CalKey,
      @UI: {
        identification: [{ hidden: true }],
        lineItem: [{ hidden: true }],
        fieldGroup: [{qualifier: 'Holiday'}]
      }
  key CalHkey,
      @UI: {
        identification: [{ position: 20 }],
        lineItem: [{ position: 20 }],
        fieldGroup: [{qualifier: 'Holiday'}]
      }
      CalMonth,
      @UI: {
        identification: [{ position: 30 }],
        lineItem: [{ position: 30 }],
        fieldGroup: [{qualifier: 'Holiday'}]
      }
      CalYear,
      @UI: {
        identification: [{ position: 40 }],
        lineItem: [{ position: 40 }],
        fieldGroup: [{qualifier: 'Holiday'}]
      }
      CalDay,
      @UI: {
        identification: [{ position: 50 }],
        lineItem: [{ position: 50 }],
        fieldGroup: [{qualifier: 'Holiday'}]
      }
      Name,
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
      Workdays : redirected to parent ZC_FCAL_WORKDAYS
}
